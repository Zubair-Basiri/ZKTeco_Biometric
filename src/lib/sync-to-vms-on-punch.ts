import { prisma } from "@/lib/prisma";
import { syncToVMS } from "@/lib/vms-client";

export async function syncEmployeeDayToVMS(employeeId: string, dateStr: string) {
  const dayStart = new Date(`${dateStr}T00:00:00Z`);
  const dayEnd = new Date(`${dateStr}T23:59:59Z`);
  const logs = await prisma.attendanceRecord.findMany({
    where: {
      employeeId: employeeId,
      occurredAt: {
        gte: dayStart,
        lt: dayEnd,
      },
    },
    include: { employee: true },
    orderBy: { occurredAt: "asc" },
  });

  if (logs.length === 0) return false;

  const firstLog = logs[0];
  if (!firstLog.employee) {
    console.warn(`No employee linked to attendance record ${firstLog.id} - skipping VMS sync`);
    return false;
  }

  const employee = firstLog.employee;
  const fullName = `${employee.firstName} ${employee.lastName}`.trim();
  // Use biometricUid as the device ID (fallback to employeeCode, but best to have biometricUid)
  const deviceId = employee.biometricUid || employee.employeeCode;
  if (!deviceId) {
    console.warn(`Employee ${employee.id} has no biometricUid or employeeCode - skipping VMS sync`);
    return false;
  }

  const payload = {
    empName: fullName,
    ID: deviceId,
    date: dateStr,
    attendanceCount: logs.length,
    checkInTimes: logs.map((log) => log.occurredAt.toISOString()),
  };

  await syncToVMS(payload);
  await prisma.attendanceRecord.updateMany({
    where: { employeeId, occurredAt: { gte: dayStart, lt: dayEnd } },
    data: { vmsSyncedAt: new Date() },
  });
  return true;
}

export async function retryPendingVmsSync() {
  const cutoff = new Date(Date.now() - 3 * 24 * 60 * 60 * 1000);
  const pending = await prisma.attendanceRecord.findMany({
    where: { employeeId: { not: null }, vmsSyncedAt: null, occurredAt: { gte: cutoff } },
    select: { employeeId: true, occurredAt: true },
    orderBy: { occurredAt: 'asc' },
  });

  const work = new Map<string, { employeeId: string; date: string }>();
  for (const record of pending) {
    if (record.employeeId) {
      const date = record.occurredAt.toISOString().slice(0, 10);
      work.set(`${record.employeeId}:${date}`, { employeeId: record.employeeId, date });
    }
  }

  for (const item of work.values()) {
    try {
      await syncEmployeeDayToVMS(item.employeeId, item.date);
    } catch (error) {
      console.error('VMS retry failed:', error);
    }
  }
}
