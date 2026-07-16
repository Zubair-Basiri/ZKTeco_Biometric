-- CreateTable
CREATE TABLE `Employee` (
    `id` VARCHAR(191) NOT NULL,
    `employeeCode` VARCHAR(191) NOT NULL,
    `firstName` VARCHAR(191) NOT NULL,
    `lastName` VARCHAR(191) NOT NULL,
    `deviceUid` INTEGER NULL,
    `deviceRole` INTEGER NULL,
    `deviceCardNo` INTEGER NULL,
    `department` VARCHAR(191) NULL,
    `designation` VARCHAR(191) NULL,
    `email` VARCHAR(191) NULL,
    `phone` VARCHAR(191) NULL,
    `biometricUid` VARCHAR(191) NULL,
    `hireDate` DATETIME(3) NULL,
    `isActive` BOOLEAN NOT NULL DEFAULT true,
    `notes` TEXT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    UNIQUE INDEX `Employee_employeeCode_key`(`employeeCode`),
    UNIQUE INDEX `Employee_email_key`(`email`),
    UNIQUE INDEX `Employee_biometricUid_key`(`biometricUid`),
    INDEX `Employee_lastName_firstName_idx`(`lastName`, `firstName`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Device` (
    `id` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `ipAddress` VARCHAR(191) NOT NULL,
    `port` INTEGER NOT NULL DEFAULT 4370,
    `commKey` INTEGER NOT NULL DEFAULT 0,
    `status` ENUM('UNKNOWN', 'ONLINE', 'OFFLINE', 'ERROR') NOT NULL DEFAULT 'UNKNOWN',
    `location` VARCHAR(191) NULL,
    `serialNumber` VARCHAR(191) NULL,
    `firmwareVersion` VARCHAR(191) NULL,
    `platform` VARCHAR(191) NULL,
    `lastSeenAt` DATETIME(3) NULL,
    `lastSyncAt` DATETIME(3) NULL,
    `notes` TEXT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    UNIQUE INDEX `Device_ipAddress_key`(`ipAddress`),
    INDEX `Device_status_updatedAt_idx`(`status`, `updatedAt`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `AttendanceRecord` (
    `id` VARCHAR(191) NOT NULL,
    `employeeId` VARCHAR(191) NULL,
    `deviceId` VARCHAR(191) NULL,
    `employeeCode` VARCHAR(191) NOT NULL,
    `occurredAt` DATETIME(3) NOT NULL,
    `type` ENUM('CHECK_IN', 'CHECK_OUT', 'BREAK_IN', 'BREAK_OUT', 'UNKNOWN') NOT NULL DEFAULT 'UNKNOWN',
    `source` ENUM('MANUAL', 'DEVICE') NOT NULL DEFAULT 'MANUAL',
    `verificationType` VARCHAR(191) NULL,
    `externalId` VARCHAR(191) NOT NULL,
    `notes` TEXT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    UNIQUE INDEX `AttendanceRecord_externalId_key`(`externalId`),
    INDEX `AttendanceRecord_employeeCode_occurredAt_idx`(`employeeCode`, `occurredAt`),
    INDEX `AttendanceRecord_deviceId_occurredAt_idx`(`deviceId`, `occurredAt`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `SyncLog` (
    `id` VARCHAR(191) NOT NULL,
    `deviceId` VARCHAR(191) NOT NULL,
    `kind` ENUM('STATUS', 'ATTENDANCE', 'USER_IMPORT') NOT NULL,
    `status` ENUM('RUNNING', 'SUCCESS', 'FAILED') NOT NULL DEFAULT 'RUNNING',
    `message` TEXT NULL,
    `recordsProcessed` INTEGER NOT NULL DEFAULT 0,
    `startedAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `finishedAt` DATETIME(3) NULL,

    INDEX `SyncLog_deviceId_startedAt_idx`(`deviceId`, `startedAt`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `AttendanceRecord` ADD CONSTRAINT `AttendanceRecord_employeeId_fkey` FOREIGN KEY (`employeeId`) REFERENCES `Employee`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `AttendanceRecord` ADD CONSTRAINT `AttendanceRecord_deviceId_fkey` FOREIGN KEY (`deviceId`) REFERENCES `Device`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `SyncLog` ADD CONSTRAINT `SyncLog_deviceId_fkey` FOREIGN KEY (`deviceId`) REFERENCES `Device`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
