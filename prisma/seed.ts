import { PrismaClient, DeviceStatus } from "@prisma/client";

const prisma = new PrismaClient();

async function main() {
  await prisma.device.upsert({
    where: { ipAddress: "192.168.1.201" },
    update: {
      name: "Main Entrance ZKTeco",
      status: DeviceStatus.UNKNOWN,
      location: "Office LAN",
    },
    create: {
      name: "Main Entrance ZKTeco",
      ipAddress: "192.168.1.201",
      port: 4370,
      commKey: 0,
      status: DeviceStatus.UNKNOWN,
      location: "Office LAN",
      notes: "Seeded from the connected device IP for first-time setup.",
    },
  });
}

main()
  .catch((error) => {
    console.error(error);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
