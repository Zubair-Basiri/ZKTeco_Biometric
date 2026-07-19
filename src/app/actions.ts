"use server";

import { revalidatePath } from "next/cache";
import { redirect } from "next/navigation";
import { z } from "zod";
import { syncDeviceUsers, runDeviceHealthCheck } from "@/lib/device-sync";
import { getErrorMessage } from "@/lib/helpers";
import { prisma } from "@/lib/prisma";
import { syncToVMS, type VmsAttendancePayload } from "@/lib/vms-client";

function formValue(formData: FormData, key: string) {
  return String(formData.get(key) ?? "").trim();
}

function optionalValue(value: string) {
  return value.length > 0 ? value : undefined;
}

function redirectWithMessage(path: string, type: "success" | "error", message: string) {
  const params = new URLSearchParams({ type, message });
  redirect(`${path}?${params.toString()}`);
}

function revalidatePortal() {
  revalidatePath("/");
  revalidatePath("/employees");
  revalidatePath("/devices");
  revalidatePath("/api/live");
}

type AttendanceLogWithEmployee = {
  id: string;
  employeeId: string;
  timestamp: Date;
  date: string;
  syncedToVMS: boolean;
  employee: {
    id: string;
    firstName: string;
    lastName: string;
    employeeCode: string;
    biometricUid: string | null;
  };
};

const deviceSchema = z.object({
  name: z.string().min(1),
  ipAddress: z.string().regex(/^\d{1,3}(\.\d{1,3}){3}$/),
  port: z.number().int().positive(),
  commKey: z.number().int().nonnegative(),
  location: z.string().optional(),
  notes: z.string().optional(),
});

export async function createDeviceAction(formData: FormData) {
  try {
    const parsed = deviceSchema.parse({
      name: formValue(formData, "name"),
      ipAddress: formValue(formData, "ipAddress"),
      port: Number(formValue(formData, "port") || "4370"),
      commKey: Number(formValue(formData, "commKey") || "0"),
      location: optionalValue(formValue(formData, "location")),
      notes: optionalValue(formValue(formData, "notes")),
    });

    await prisma.device.create({
      data: parsed,
    });

    revalidatePortal();
  } catch (error) {
    return redirectWithMessage("/devices", "error", getErrorMessage(error));
  }

  redirectWithMessage("/devices", "success", "Device registered successfully.");
}

export async function checkDeviceAction(formData: FormData) {
  const deviceId = formValue(formData, "deviceId");

  try {
    await runDeviceHealthCheck(deviceId);
    revalidatePortal();
  } catch (error) {
    return redirectWithMessage("/devices", "error", getErrorMessage(error));
  }

  redirectWithMessage("/devices", "success", "Device heartbeat completed.");
}

export async function syncDeviceUsersAction(formData: FormData) {
  const deviceId = formValue(formData, "deviceId");

  let processed = 0;

  try {
    processed = await syncDeviceUsers(deviceId);
    revalidatePortal();
  } catch (error) {
    return redirectWithMessage("/devices", "error", getErrorMessage(error));
  }

  redirectWithMessage("/devices", "success", `User sync finished. ${processed} records processed.`);
}

// This will be called by your cron job
export async function syncAttendanceToVMS() {
  console.log("🚀 Sync job started.");

  const unsyncedLogs = (await prisma.attendanceLog.findMany({
    where: { syncedToVMS: false },
    include: { employee: true },
    orderBy: { timestamp: "asc" },
  })) as unknown as AttendanceLogWithEmployee[];

  if (unsyncedLogs.length === 0) {
    console.log("📭 No new attendance logs to sync.");
    return;
  }

  const groupedLogs: Record<string, VmsAttendancePayload> = {};
  for (const log of unsyncedLogs) {
    const key = `${log.employeeId}_${log.date}`;
    if (!groupedLogs[key]) {
      groupedLogs[key] = {
        empName: `${log.employee.firstName} ${log.employee.lastName}`.trim(),
        ID: log.employee.biometricUid || log.employee.employeeCode,
        date: log.date,
        checkInTimes: [],
        attendanceCount: 0,
      };
    }
    groupedLogs[key].checkInTimes.push(log.timestamp.toISOString());
    groupedLogs[key].attendanceCount++;
  }

  for (const payload of Object.values(groupedLogs)) {
    await syncToVMS(payload);
  }

  await prisma.attendanceLog.updateMany({
    where: { id: { in: unsyncedLogs.map(log => log.id) } },
    data: { syncedToVMS: true },
  });

  console.log(`✨ Sync job finished. Synced ${unsyncedLogs.length} logs.`);
}
