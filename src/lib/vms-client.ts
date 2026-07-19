const VMS_API_URL = process.env.VMS_API_URL;
const VMS_API_KEY = process.env.VMS_API_KEY;

export type VmsAttendancePayload = {
  empName: string;
  ID: string;
  date: string;
  attendanceCount: number;
  checkInTimes: string[];
};

export async function syncToVMS(payload: VmsAttendancePayload) {
  if (!VMS_API_URL || !VMS_API_KEY) {
    throw new Error("VMS_API_URL and VMS_API_KEY must be configured");
  }
  const response = await fetch(VMS_API_URL, {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
      "X-ZK-Sync-Key": VMS_API_KEY,
    },
    body: JSON.stringify(payload),
  });

  if (!response.ok) {
    const errorText = await response.text();
    throw new Error(`VMS sync failed (${response.status}): ${errorText}`);
  }

  return response.json();
}
