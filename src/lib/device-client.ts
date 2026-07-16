import type { Device } from "@/lib/prisma-client";
import ZKLib from "node-zklib";
import { env } from "@/lib/env";

type DeviceUser = {
  uid: number;
  role: number;
  name?: string;
  userId?: string;
  cardno?: number;
};

type DeviceAttendance = {
  userId?: string;
  deviceUserId?: number | string;
  userSn?: number;
  recordTime: Date;
};

type DeviceInfo = {
  userCounts: number;
  logCounts: number;
  logCapacity: number;
};

export type DeviceSnapshot = {
  info: DeviceInfo;
  users: DeviceUser[];
  attendances: DeviceAttendance[];
  deviceTime: Date | null;
};

type ZKDevice = Pick<Device, "ipAddress" | "port" | "commKey">;

function buildClient(device: ZKDevice) {
  return new ZKLib(
    device.ipAddress,
    device.port || env.ZK_DEFAULT_PORT,
    env.ZK_TIMEOUT_MS,
    env.ZK_INPORT,
    device.commKey || 0,
    "tcp",
  );
}

async function disconnectQuietly(client: ZKLib) {
  try {
    await client.disconnect();
  } catch {
    // Ignore disconnect failures; they are not actionable for the caller.
  }
}

export async function withDeviceClient<T>(
  device: ZKDevice,
  callback: (client: ZKLib) => Promise<T>,
) {
  const client = buildClient(device);

  try {
    await client.createSocket();
    return await callback(client);
  } finally {
    await disconnectQuietly(client);
  }
}

export async function getDeviceSnapshot(device: ZKDevice): Promise<DeviceSnapshot> {
  return withDeviceClient(device, async (client) => {
    const info = await client.getInfo();
    const users = await client.getUsers();
    const attendances = await client.getAttendances();
    const deviceTime =
      typeof client.getTime === "function" ? await client.getTime() : null;

    return {
      info,
      users: users.data,
      attendances: attendances.data,
      deviceTime,
    };
  });
}

export async function getDeviceHealth(device: ZKDevice) {
  return withDeviceClient(device, async (client) => {
    const info = await client.getInfo();
    const deviceTime =
      typeof client.getTime === "function" ? await client.getTime() : null;

    return {
      info,
      deviceTime,
      lastSeenAt: new Date(),
    };
  });
}

export async function getDeviceUsers(device: ZKDevice) {
  return withDeviceClient(device, async (client) => {
    const users = await client.getUsers();
    return users.data;
  });
}

export async function getDeviceAttendances(device: ZKDevice) {
  return withDeviceClient(device, async (client) => {
    const attendances = await client.getAttendances();
    return attendances.data;
  });
}
