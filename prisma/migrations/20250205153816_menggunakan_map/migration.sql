/*
  Warnings:

  - You are about to drop the column `createdAt` on the `rekening` table. All the data in the column will be lost.
  - You are about to drop the column `updatedAt` on the `rekening` table. All the data in the column will be lost.
  - You are about to drop the column `createdAt` on the `transaksi` table. All the data in the column will be lost.
  - You are about to drop the column `updatedAt` on the `transaksi` table. All the data in the column will be lost.
  - You are about to alter the column `nominal` on the `transaksi` table. The data in that column could be lost. The data in that column will be cast from `VarChar(191)` to `Int`.
  - You are about to drop the column `createdAt` on the `user` table. All the data in the column will be lost.
  - You are about to drop the column `updatedAt` on the `user` table. All the data in the column will be lost.
  - You are about to drop the column `createdAt` on the `utang` table. All the data in the column will be lost.
  - You are about to drop the column `updatedAt` on the `utang` table. All the data in the column will be lost.
  - You are about to drop the `kategoritransaksi` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `masterdefaultkategoritransaksi` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `mastericonrekening` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `mastericontransaction` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `masterrekeningkategori` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `updated_at` to the `rekening` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updated_at` to the `transaksi` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updated_at` to the `user` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updated_at` to the `utang` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE `kategoritransaksi` DROP FOREIGN KEY `KategoriTransaksi_id_icon_fkey`;

-- DropForeignKey
ALTER TABLE `kategoritransaksi` DROP FOREIGN KEY `KategoriTransaksi_id_user_fkey`;

-- DropForeignKey
ALTER TABLE `masterdefaultkategoritransaksi` DROP FOREIGN KEY `MasterDefaultKategoriTransaksi_id_icon_fkey`;

-- DropForeignKey
ALTER TABLE `rekening` DROP FOREIGN KEY `Rekening_id_icon_fkey`;

-- DropForeignKey
ALTER TABLE `rekening` DROP FOREIGN KEY `Rekening_id_kategori_fkey`;

-- DropForeignKey
ALTER TABLE `rekening` DROP FOREIGN KEY `Rekening_id_user_fkey`;

-- DropForeignKey
ALTER TABLE `transaksi` DROP FOREIGN KEY `Transaksi_id_kategori_fkey`;

-- DropForeignKey
ALTER TABLE `transaksi` DROP FOREIGN KEY `Transaksi_id_parent_fkey`;

-- DropForeignKey
ALTER TABLE `transaksi` DROP FOREIGN KEY `Transaksi_id_rekening_fkey`;

-- DropForeignKey
ALTER TABLE `transaksi` DROP FOREIGN KEY `Transaksi_id_user_fkey`;

-- DropForeignKey
ALTER TABLE `transaksi` DROP FOREIGN KEY `Transaksi_id_utang_fkey`;

-- DropForeignKey
ALTER TABLE `utang` DROP FOREIGN KEY `Utang_id_user_fkey`;

-- DropIndex
DROP INDEX `Rekening_id_icon_fkey` ON `rekening`;

-- DropIndex
DROP INDEX `Rekening_id_kategori_fkey` ON `rekening`;

-- DropIndex
DROP INDEX `Transaksi_id_kategori_fkey` ON `transaksi`;

-- AlterTable
ALTER TABLE `rekening` DROP COLUMN `createdAt`,
    DROP COLUMN `updatedAt`,
    ADD COLUMN `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    ADD COLUMN `updated_at` DATETIME(3) NOT NULL;

-- AlterTable
ALTER TABLE `transaksi` DROP COLUMN `createdAt`,
    DROP COLUMN `updatedAt`,
    ADD COLUMN `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    ADD COLUMN `updated_at` DATETIME(3) NOT NULL,
    MODIFY `nominal` INTEGER NOT NULL;

-- AlterTable
ALTER TABLE `user` DROP COLUMN `createdAt`,
    DROP COLUMN `updatedAt`,
    ADD COLUMN `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    ADD COLUMN `updated_at` DATETIME(3) NOT NULL;

-- AlterTable
ALTER TABLE `utang` DROP COLUMN `createdAt`,
    DROP COLUMN `updatedAt`,
    ADD COLUMN `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    ADD COLUMN `updated_at` DATETIME(3) NOT NULL;

-- DropTable
DROP TABLE `kategoritransaksi`;

-- DropTable
DROP TABLE `masterdefaultkategoritransaksi`;

-- DropTable
DROP TABLE `mastericonrekening`;

-- DropTable
DROP TABLE `mastericontransaction`;

-- DropTable
DROP TABLE `masterrekeningkategori`;

-- CreateTable
CREATE TABLE `master_icon_rekening` (
    `id` VARCHAR(191) NOT NULL,
    `nama` VARCHAR(191) NOT NULL,
    `icon` VARCHAR(191) NOT NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `master_icon_transaction` (
    `id` VARCHAR(191) NOT NULL,
    `nama` VARCHAR(191) NOT NULL,
    `icon` VARCHAR(191) NOT NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `master_rekening_kategori` (
    `id` VARCHAR(191) NOT NULL,
    `nama` VARCHAR(191) NOT NULL,
    `icon` VARCHAR(191) NOT NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `master_default_kategori_transaksi` (
    `id` VARCHAR(191) NOT NULL,
    `id_icon` VARCHAR(191) NOT NULL,
    `tipe` VARCHAR(191) NOT NULL,
    `nama` VARCHAR(191) NOT NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `kategori_transaksi` (
    `id` VARCHAR(191) NOT NULL,
    `id_user` VARCHAR(191) NOT NULL,
    `id_icon` VARCHAR(191) NOT NULL,
    `tipe` VARCHAR(191) NOT NULL,
    `nama` VARCHAR(191) NOT NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `master_default_kategori_transaksi` ADD CONSTRAINT `master_default_kategori_transaksi_id_icon_fkey` FOREIGN KEY (`id_icon`) REFERENCES `master_icon_transaction`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `kategori_transaksi` ADD CONSTRAINT `kategori_transaksi_id_user_fkey` FOREIGN KEY (`id_user`) REFERENCES `user`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `kategori_transaksi` ADD CONSTRAINT `kategori_transaksi_id_icon_fkey` FOREIGN KEY (`id_icon`) REFERENCES `master_icon_transaction`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `rekening` ADD CONSTRAINT `rekening_id_user_fkey` FOREIGN KEY (`id_user`) REFERENCES `user`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `rekening` ADD CONSTRAINT `rekening_id_kategori_fkey` FOREIGN KEY (`id_kategori`) REFERENCES `master_rekening_kategori`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `rekening` ADD CONSTRAINT `rekening_id_icon_fkey` FOREIGN KEY (`id_icon`) REFERENCES `master_icon_rekening`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `transaksi` ADD CONSTRAINT `transaksi_id_user_fkey` FOREIGN KEY (`id_user`) REFERENCES `user`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `transaksi` ADD CONSTRAINT `transaksi_id_rekening_fkey` FOREIGN KEY (`id_rekening`) REFERENCES `rekening`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `transaksi` ADD CONSTRAINT `transaksi_id_kategori_fkey` FOREIGN KEY (`id_kategori`) REFERENCES `kategori_transaksi`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `transaksi` ADD CONSTRAINT `transaksi_id_utang_fkey` FOREIGN KEY (`id_utang`) REFERENCES `utang`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `transaksi` ADD CONSTRAINT `transaksi_id_parent_fkey` FOREIGN KEY (`id_parent`) REFERENCES `transaksi`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `utang` ADD CONSTRAINT `utang_id_user_fkey` FOREIGN KEY (`id_user`) REFERENCES `user`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- RenameIndex
ALTER TABLE `user` RENAME INDEX `User_email_key` TO `user_email_key`;
