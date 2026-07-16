const VMS_API_URL = process.env.VMS_API_URL!;
const VMS_API_KEY = process.env.VMS_API_KEY!;

export async function syncToVMS(payload: any) {
  const response = await fetch(VMS_API_URL, {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify(payload),
  });

  if (!response.ok) {
    const errorText = await response.text();
    throw new Error(`VMS sync failed (${response.status}): ${errorText}`);
  }

  return response.json();
}