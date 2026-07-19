import { AttendanceSource, AttendanceType, DeviceStatus } from "@/lib/prisma-client";
import { getDeviceAttendances, getDeviceUsers } from "@/lib/device-client";
import { upsertDeviceUsersForDirectory, findEmployeeByDeviceCode, type SyncableDeviceUser } from "@/lib/device-directory";
import { env } from "@/lib/env";
import { sanitizeCode } from "@/lib/helpers";
import { prisma } from "@/lib/prisma";
import { syncEmployeeDayToVMS } from "@/lib/sync-to-vms-on-punch";

type DeviceConfig = {
  id: string;
  name: string;
  ipAddress: string;
  port: number;
  commKey: number;
};

type MonitorEntry = {
  deviceId: string;
  lastAttendanceSyncAt: number;
  syncingAttendance: boolean;
};

type MonitorState = {
  monitors: Map<string, MonitorEntry>;
  ensuring: Promise<void> | null;
};

const globalForMonitor = globalThis as unknown as {
  zkMonitorState?: MonitorState;
};

const monitorState =
  globalForMonitor.zkMonitorState ??
  {
    monitors: new Map<string, MonitorEntry>(),
    ensuring: null,
  };

const attendanceFallbackIntervalMs = Math.min(env.LIVE_SYNC_INTERVAL_MS, 2_000);

if (!globalForMonitor.zkMonitorState) {
  globalForMonitor.zkMonitorState = monitorState;
}

function buildAttendanceExternalId(deviceId: string, code: string, occurredAt: Date) {
  return `DEVICE:${deviceId}:${code}:${occurredAt.toISOString()}`;
}

async function setDeviceStatus(deviceId: string, status: DeviceStatus) {
  await prisma.device.update({
    where: { id: deviceId },
    data: {
      status,
      lastSeenAt: status === DeviceStatus.ONLINE ? new Date() : undefined,
      lastSyncAt: new Date(),
    },
  }).catch(() => {
    // Ignore stale updates when the device row is modified or removed.
  });
}

async function refreshUsersFromDevice(device: DeviceConfig) {
  const users = await getDeviceUsers(device);
  await upsertDeviceUsersForDirectory(device, users as SyncableDeviceUser[]);
}

async function upsertAttendanceEvent(device: DeviceConfig, rawCode: string, occurredAt: Date) {
  let employee = await findEmployeeByDeviceCode(rawCode);

  if (!employee) {
    try {
      await refreshUsersFromDevice(device);
      employee = await findEmployeeByDeviceCode(rawCode);
    } catch {
      // If refresh fails, still record the punch against the raw device code.
    }
  }

  const externalId = buildAttendanceExternalId(device.id, rawCode, occurredAt);

  // Check if this record already exists (to avoid duplicate VMS sync)
  const existing = await prisma.attendanceRecord.findUnique({
    where: { externalId },
    select: { id: true },
  });

  await prisma.attendanceRecord.upsert({
    where: { externalId },
    update: {
      employeeId: employee?.id,
      employeeCode: employee?.employeeCode ?? rawCode,
      deviceId: device.id,
      occurredAt,
      source: AttendanceSource.DEVICE,
      type: AttendanceType.UNKNOWN,
      verificationType: "fingerprint",
      notes: `Live fingerprint punch from ${device.name}`,
    },
    create: {
      employeeId: employee?.id,
      employeeCode: employee?.employeeCode ?? rawCode,
      deviceId: device.id,
      occurredAt,
      source: AttendanceSource.DEVICE,
      type: AttendanceType.UNKNOWN,
      verificationType: "fingerprint",
      externalId,
      notes: `Live fingerprint punch from ${device.name}`,
    },
  });

  // --- ONLY trigger VMS sync if this is a NEW record (not an update) ---
  if (!existing && employee?.id) {
    const dateStr = occurredAt.toISOString().split('T')[0];
    // Fire-and-forget; errors are caught inside
    syncEmployeeDayToVMS(employee.id, dateStr).catch(err =>
      console.error("VMS sync error (non-critical):", err.message)
    );
  }
}

async function syncAttendancesFromDevice(deviceId: string) {
  const device = await loadDevice(deviceId);

  if (!device) {
    return;
  }

  try {
    const attendances = await getDeviceAttendances(device);

    for (const attendance of attendances) {
      const rawCode =
        sanitizeCode(attendance.userId || "") ||
        sanitizeCode(String(attendance.deviceUserId || "")) ||
        sanitizeCode(String(attendance.userSn || ""));

      if (!rawCode) {
        continue;
      }

      const occurredAt = new Date(attendance.recordTime);

      if (Number.isNaN(occurredAt.getTime())) {
        continue;
      }

      await upsertAttendanceEvent(device, rawCode, occurredAt);
    }

    await setDeviceStatus(device.id, DeviceStatus.ONLINE);
  } catch (error) {
    await setDeviceStatus(device.id, DeviceStatus.OFFLINE);
    console.error(`Attendance read failed for ${device.ipAddress}:`, error);
  }
}

async function maybeSyncAttendancesFromDevice(deviceId: string, force = false) {
  const monitor = monitorState.monitors.get(deviceId);

  if (!monitor || monitor.syncingAttendance) {
    return;
  }

  if (!force && Date.now() - monitor.lastAttendanceSyncAt < attendanceFallbackIntervalMs) {
    return;
  }

  monitor.syncingAttendance = true;
  monitor.lastAttendanceSyncAt = Date.now();

  try {
    await syncAttendancesFromDevice(deviceId);
  } finally {
    monitor.syncingAttendance = false;
  }
}

async function loadDevice(deviceId: string) {
  return prisma.device.findUnique({
    where: { id: deviceId },
    select: {
      id: true,
      name: true,
      ipAddress: true,
      port: true,
      commKey: true,
    },
  });
}

async function startMonitor(deviceId: string) {
  const existing = monitorState.monitors.get(deviceId);

  if (existing) {
    return;
  }

  const device = await loadDevice(deviceId);

  if (!device) {
    return;
  }

  const monitor = {
    deviceId,
    lastAttendanceSyncAt: 0,
    syncingAttendance: false,
  };

  monitorState.monitors.set(deviceId, monitor);
}

export async function ensureDeviceMonitoring() {
  if (!monitorState.ensuring) {
    monitorState.ensuring = (async () => {
      const devices = await prisma.device.findMany({
        select: {
          id: true,
        },
      });

      for (const device of devices) {
        await startMonitor(device.id);
      }
    })().finally(() => {
      monitorState.ensuring = null;
    });
  }

  return monitorState.ensuring;
}

export async function ensureDeviceAttendanceBackfill() {
  await ensureDeviceMonitoring();

  const deviceIds = Array.from(monitorState.monitors.keys());
  await Promise.all(
    deviceIds.map((deviceId) => maybeSyncAttendancesFromDevice(deviceId)),
  );
}
