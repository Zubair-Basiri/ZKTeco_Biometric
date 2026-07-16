import { AttendanceSource, DeviceStatus } from "@/lib/prisma-client";
import { ensureDeviceAttendanceBackfill, ensureDeviceMonitoring } from "@/lib/device-monitor";
import { prisma } from "@/lib/prisma";
import { getEmployeeName } from "@/lib/helpers";

export type EmployeeDirectoryItem = {
  id: string;
  name: string;
  employeeCode: string;
  biometricUid: string | null;
  deviceUid: number | null;
  deviceRole: number | null;
  deviceCardNo: number | null;
  department: string | null;
  designation: string | null;
  email: string | null;
  phone: string | null;
  hireDate: Date | null;
  isActive: boolean;
  notes: string | null;
  attendanceCount: number;
  lastAttendanceAt: Date | null;
  lastAttendanceSource: AttendanceSource | null;
  lastDeviceName: string | null;
};

export type DevicesPageItem = {
  id: string;
  name: string;
  ipAddress: string;
  port: number;
  commKey: number;
  location: string | null;
  status: DeviceStatus;
  lastSeenAt: Date | null;
  lastSyncAt: Date | null;
  notes: string | null;
  attendanceCount: number;
};

export type LiveDeviceStatusItem = {
  id: string;
  name: string;
  ipAddress: string;
  location: string | null;
  status: DeviceStatus;
  lastSeenAt: Date | null;
  lastSyncAt: Date | null;
};

export type LivePunchItem = {
  id: string;
  employeeName: string;
  employeeCode: string;
  biometricUid: string;
  deviceUid: number | null;
  deviceRole: number | null;
  deviceCardNo: number | null;
  department: string | null;
  designation: string | null;
  occurredAt: Date;
  deviceName: string;
  deviceIp: string | null;
  deviceStatus: DeviceStatus;
  verificationType: string | null;
};

export type EmployeesPageData = {
  employees: EmployeeDirectoryItem[];
};

export type DevicesPageData = {
  devices: DevicesPageItem[];
};

export type LiveDeviceFeedData = {
  devices: LiveDeviceStatusItem[];
  recentPunches: LivePunchItem[];
};

export async function getEmployeesPageData(): Promise<EmployeesPageData> {
  await ensureDeviceMonitoring();

  const employees = await prisma.employee.findMany({
    orderBy: [{ updatedAt: "desc" }],
    include: {
      attendances: {
        take: 1,
        orderBy: { occurredAt: "desc" },
        include: {
          device: {
            select: {
              name: true,
            },
          },
        },
      },
      _count: {
        select: {
          attendances: true,
        },
      },
    },
  });

  return {
    employees: employees.map((employee: (typeof employees)[number]) => ({
      id: employee.id,
      name: getEmployeeName(employee),
      employeeCode: employee.employeeCode,
      biometricUid: employee.biometricUid,
      deviceUid: employee.deviceUid,
      deviceRole: employee.deviceRole,
      deviceCardNo: employee.deviceCardNo,
      department: employee.department,
      designation: employee.designation,
      email: employee.email,
      phone: employee.phone,
      hireDate: employee.hireDate,
      isActive: employee.isActive,
      notes: employee.notes,
      attendanceCount: employee._count.attendances,
      lastAttendanceAt: employee.attendances[0]?.occurredAt ?? null,
      lastAttendanceSource: employee.attendances[0]?.source ?? null,
      lastDeviceName: employee.attendances[0]?.device?.name ?? null,
    })),
  };
}

export async function getDevicesPageData(): Promise<DevicesPageData> {
  await ensureDeviceMonitoring();

  const devices = await prisma.device.findMany({
    orderBy: [{ updatedAt: "desc" }],
    include: {
      _count: {
        select: {
          attendances: true,
        },
      },
    },
  });

  return {
    devices: devices.map((device: (typeof devices)[number]) => ({
      id: device.id,
      name: device.name,
      ipAddress: device.ipAddress,
      port: device.port,
      commKey: device.commKey,
      location: device.location,
      status: device.status,
      lastSeenAt: device.lastSeenAt,
      lastSyncAt: device.lastSyncAt,
      notes: device.notes,
      attendanceCount: device._count.attendances,
    })),
  };
}

export async function getLiveDeviceFeed(): Promise<LiveDeviceFeedData> {
  await ensureDeviceMonitoring();
  await ensureDeviceAttendanceBackfill();

  const [devices, recentPunches] = await Promise.all([
    prisma.device.findMany({
      orderBy: [{ updatedAt: "desc" }],
      select: {
        id: true,
        name: true,
        ipAddress: true,
        status: true,
        location: true,
        lastSeenAt: true,
        lastSyncAt: true,
      },
    }),
    prisma.attendanceRecord.findMany({
      where: { source: AttendanceSource.DEVICE },
      take: 40,
      orderBy: { occurredAt: "desc" },
      include: {
        employee: {
          select: {
            firstName: true,
            lastName: true,
            employeeCode: true,
            biometricUid: true,
            deviceUid: true,
            deviceRole: true,
            deviceCardNo: true,
            department: true,
            designation: true,
          },
        },
        device: {
          select: {
            id: true,
            name: true,
            ipAddress: true,
            status: true,
          },
        },
      },
    }),
  ]);

  return {
    devices: devices.map((device: (typeof devices)[number]) => ({
      id: device.id,
      name: device.name,
      ipAddress: device.ipAddress,
      location: device.location,
      status: device.status,
      lastSeenAt: device.lastSeenAt,
      lastSyncAt: device.lastSyncAt,
    })),
    recentPunches: recentPunches.map((record: (typeof recentPunches)[number]) => ({
      id: record.id,
      employeeName: record.employee ? getEmployeeName(record.employee) : record.employeeCode,
      employeeCode: record.employee?.employeeCode ?? record.employeeCode,
      biometricUid: record.employee?.biometricUid ?? record.employeeCode,
      deviceUid: record.employee?.deviceUid ?? null,
      deviceRole: record.employee?.deviceRole ?? null,
      deviceCardNo: record.employee?.deviceCardNo ?? null,
      department: record.employee?.department ?? null,
      designation: record.employee?.designation ?? null,
      occurredAt: record.occurredAt,
      deviceName: record.device?.name ?? "Unknown device",
      deviceIp: record.device?.ipAddress ?? null,
      deviceStatus: record.device?.status ?? DeviceStatus.UNKNOWN,
      verificationType: record.verificationType,
    })),
  };
}
