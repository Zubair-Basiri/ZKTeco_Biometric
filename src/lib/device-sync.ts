import { DeviceStatus, SyncKind, SyncStatus } from "@/lib/prisma-client";
import { getDeviceHealth, getDeviceUsers } from "@/lib/device-client";
import { upsertDeviceUsersForDirectory } from "@/lib/device-directory";
import { getErrorMessage } from "@/lib/helpers";
import { prisma } from "@/lib/prisma";

async function getDeviceOrThrow(deviceId: string) {
  const device = await prisma.device.findUnique({
    where: { id: deviceId },
    select: {
      id: true,
      name: true,
      ipAddress: true,
      port: true,
      commKey: true,
    },
  });

  if (!device) {
    throw new Error("Device not found");
  }

  return device;
}

async function createSyncLog(deviceId: string, kind: SyncKind) {
  return prisma.syncLog.create({
    data: {
      deviceId,
      kind,
      status: SyncStatus.RUNNING,
    },
  });
}

async function finishSyncLog(
  syncLogId: string,
  status: SyncStatus,
  message: string,
  recordsProcessed = 0,
) {
  await prisma.syncLog.update({
    where: { id: syncLogId },
    data: {
      status,
      message,
      recordsProcessed,
      finishedAt: new Date(),
    },
  });
}

async function markDeviceStatus(deviceId: string, status: DeviceStatus) {
  await prisma.device.update({
    where: { id: deviceId },
    data: {
      status,
      lastSeenAt: status === DeviceStatus.ONLINE ? new Date() : undefined,
      lastSyncAt: new Date(),
    },
  });
}

export async function runDeviceHealthCheck(deviceId: string) {
  const device = await getDeviceOrThrow(deviceId);
  const syncLog = await createSyncLog(device.id, SyncKind.STATUS);

  try {
    const health = await getDeviceHealth(device);

    await prisma.device.update({
      where: { id: device.id },
      data: {
        status: DeviceStatus.ONLINE,
        lastSeenAt: health.lastSeenAt,
        lastSyncAt: new Date(),
      },
    });

    await finishSyncLog(
      syncLog.id,
      SyncStatus.SUCCESS,
      health.deviceTime
        ? `Connected successfully. Device time ${health.deviceTime.toISOString()} and ${health.info.logCounts} attendance logs reported.`
        : `Connected successfully. The device responded with ${health.info.logCounts} attendance logs, but the published node-zklib wrapper does not expose device time.`,
    );

    return health;
  } catch (error) {
    await prisma.device.update({
      where: { id: device.id },
      data: {
        status: DeviceStatus.OFFLINE,
        lastSyncAt: new Date(),
      },
    });

    await finishSyncLog(syncLog.id, SyncStatus.FAILED, getErrorMessage(error));
    throw error;
  }
}

export async function syncDeviceUsers(deviceId: string) {
  const device = await getDeviceOrThrow(deviceId);
  const syncLog = await createSyncLog(device.id, SyncKind.USER_IMPORT);

  try {
    const users = await getDeviceUsers(device);
    const processed = await upsertDeviceUsersForDirectory(device, users);

    await markDeviceStatus(device.id, DeviceStatus.ONLINE);
    await finishSyncLog(
      syncLog.id,
      SyncStatus.SUCCESS,
      `Imported or refreshed ${processed} device users.`,
      processed,
    );

    return processed;
  } catch (error) {
    await markDeviceStatus(device.id, DeviceStatus.ERROR);
    await finishSyncLog(syncLog.id, SyncStatus.FAILED, getErrorMessage(error));
    throw error;
  }
}
