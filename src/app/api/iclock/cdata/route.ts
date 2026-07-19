import { NextRequest } from "next/server";
import { prisma } from "@/lib/prisma";
import { syncEmployeeDayToVMS } from "@/lib/sync-to-vms-on-punch";

export const dynamic = "force-dynamic";
export const runtime = "nodejs";

export async function GET(request: NextRequest) {
  console.log("[GET] Device handshake received");
  // Device handshake
  const sn = request.nextUrl.searchParams.get("SN");
  console.log(`[Handshake] Device SN: ${sn}`);
  return new Response("OK", { status: 200 });
}

export async function POST(request: NextRequest) {
  try {
    console.log("Post method recieved");
    const text = await request.text();
    const lines = text.split("\n").filter((line: string) => line.trim());

    for (const line of lines) {
      const parts = line.split("\t");
      const [userId, timestampStr, status] = parts; // adjust indices as needed

      if (!userId || !timestampStr) continue;

      const timestamp = new Date(timestampStr);
      const date = timestamp.toISOString().split("T")[0];

      // Find employee by the biometric user ID stored on the device.
      const employee = await prisma.employee.findUnique({
        where: { biometricUid: userId },
      });

      if (!employee) {
        console.warn(`Employee with deviceId ${userId} not found`);
        continue;
      }

      // Save local attendance log
      await prisma.attendanceLog.create({
        data: {
          employeeId: employee.id,
          timestamp,
          date,
          status: status || "CHECK_IN",
        },
      });

      // Fire-and-forget sync to VMS
      syncEmployeeDayToVMS(employee.id, date).catch((err: Error) =>
        console.error("VMS sync error:", err)
      );
    }

    return new Response("OK", { status: 200 });
  } catch (error) {
    console.error("Error processing device push:", error);
    return new Response("ERROR", { status: 500 });
  }
}
