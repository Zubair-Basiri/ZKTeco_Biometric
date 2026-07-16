import { prisma } from "@/lib/prisma";
import { syncToVMS } from "@/lib/vms-client";

export async function syncEmployeeDayToVMS(employeeId: string, dateStr: string) {
  const logs = await prisma.attendanceRecord.findMany({
    where: {
      employeeId: employeeId,
      occurredAt: {
        gte: new Date(`${dateStr}T00:00:00Z`),
        lt: new Date(`${dateStr}T23:59:59Z`),
      },
    },
    include: { employee: true },
    orderBy: { occurredAt: "asc" },
  });

  if (logs.length === 0) return;

  const firstLog = logs[0];
  if (!firstLog.employee) {
    console.warn(`No employee linked to attendance record ${firstLog.id} - skipping VMS sync`);
    return;
  }

  const employee = firstLog.employee;
  const fullName = `${employee.firstName} ${employee.lastName}`.trim();
  // Use biometricUid as the device ID (fallback to employeeCode, but best to have biometricUid)
  const deviceId = employee.biometricUid || employee.employeeCode;
  if (!deviceId) {
    console.warn(`Employee ${employee.id} has no biometricUid or employeeCode - skipping VMS sync`);
    return;
  }

  const payload = {
    empName: fullName,
    ID: deviceId,
    date: dateStr,
    attendanceCount: logs.length,
    checkInTimes: logs.map((log) => log.occurredAt.toISOString()),
  };

  await syncToVMS(payload);
}