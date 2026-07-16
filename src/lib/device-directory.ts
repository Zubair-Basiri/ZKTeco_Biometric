import { prisma } from "@/lib/prisma";
import { sanitizeCode, splitFullName } from "@/lib/helpers";

export type SyncableDeviceUser = {
  uid: number;
  role: number;
  name?: string;
  userId?: string;
  cardno?: number;
};

type DirectoryDevice = {
  id: string;
  name: string;
  ipAddress: string;
};

function buildLookup<T extends { id: string; employeeCode: string; biometricUid: string | null }>(items: T[]) {
  const lookup = new Map<string, T>();

  for (const item of items) {
    lookup.set(item.employeeCode.toUpperCase(), item);

    if (item.biometricUid) {
      lookup.set(item.biometricUid.toUpperCase(), item);
    }
  }

  return lookup;
}

function nextEmployeeCode(baseCode: string, usedCodes: Set<string>) {
  const root = sanitizeCode(baseCode) || "DEVICE-USER";

  if (!usedCodes.has(root)) {
    usedCodes.add(root);
    return root;
  }

  let counter = 1;
  let candidate = `${root}-${counter}`;

  while (usedCodes.has(candidate)) {
    counter += 1;
    candidate = `${root}-${counter}`;
  }

  usedCodes.add(candidate);
  return candidate;
}

export async function upsertDeviceUsersForDirectory(
  device: DirectoryDevice,
  users: SyncableDeviceUser[],
) {
  const employees = await prisma.employee.findMany({
    select: {
      id: true,
      employeeCode: true,
      biometricUid: true,
    },
  });

  const employeeLookup = buildLookup(employees);
  const usedCodes: Set<string> = new Set(
    employees.map((employee: (typeof employees)[number]) => employee.employeeCode),
  );
  let processed = 0;

  for (const user of users) {
    const biometricUid =
      sanitizeCode(user.userId || "") || sanitizeCode(String(user.uid));

    if (!biometricUid) {
      continue;
    }

    const existing = employeeLookup.get(biometricUid);
    const names = splitFullName(user.name || `Device User ${biometricUid}`);

    const payload = {
      firstName: names.firstName,
      lastName: names.lastName,
      biometricUid,
      deviceUid: user.uid,
      deviceRole: user.role,
      deviceCardNo: user.cardno ?? null,
      isActive: true,
      notes: `Imported from device ${device.name} (${device.ipAddress})`,
    };

    if (existing) {
      await prisma.employee.update({
        where: { id: existing.id },
        data: payload,
      });
    } else {
      const employeeCode = nextEmployeeCode(biometricUid, usedCodes);
      const created = await prisma.employee.create({
        data: {
          employeeCode,
          ...payload,
        },
        select: {
          id: true,
          employeeCode: true,
          biometricUid: true,
        },
      });

      employeeLookup.set(created.employeeCode.toUpperCase(), created);

      if (created.biometricUid) {
        employeeLookup.set(created.biometricUid.toUpperCase(), created);
      }
    }

    processed += 1;
  }

  return processed;
}

export async function findEmployeeByDeviceCode(code: string) {
  const normalized = sanitizeCode(code);

  if (!normalized) {
    return null;
  }

  return prisma.employee.findFirst({
    where: {
      OR: [
        { biometricUid: normalized },
        { employeeCode: normalized },
      ],
    },
    select: {
      id: true,
      firstName: true,
      lastName: true,
      employeeCode: true,
      biometricUid: true,
      deviceUid: true,
      deviceRole: true,
      deviceCardNo: true,
    },
  });
}
