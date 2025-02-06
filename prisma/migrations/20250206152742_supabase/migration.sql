-- CreateTable
CREATE TABLE "user" (
    "id" TEXT NOT NULL,
    "username" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "role" TEXT NOT NULL,
    "saldo" INTEGER NOT NULL,
    "ccy" TEXT NOT NULL,
    "pin" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "user_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "master_icon_rekening" (
    "id" TEXT NOT NULL,
    "nama" TEXT NOT NULL,
    "icon" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "master_icon_rekening_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "master_icon_transaction" (
    "id" TEXT NOT NULL,
    "nama" TEXT NOT NULL,
    "icon" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "master_icon_transaction_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "master_rekening_kategori" (
    "id" TEXT NOT NULL,
    "nama" TEXT NOT NULL,
    "icon" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "master_rekening_kategori_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "master_default_kategori_transaksi" (
    "id" TEXT NOT NULL,
    "id_icon" TEXT NOT NULL,
    "tipe" TEXT NOT NULL,
    "nama" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "master_default_kategori_transaksi_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "kategori_transaksi" (
    "id" TEXT NOT NULL,
    "id_user" TEXT NOT NULL,
    "id_icon" TEXT NOT NULL,
    "tipe" TEXT NOT NULL,
    "nama" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "kategori_transaksi_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "rekening" (
    "id" TEXT NOT NULL,
    "id_user" TEXT NOT NULL,
    "id_kategori" TEXT NOT NULL,
    "id_icon" TEXT NOT NULL,
    "no_rekening" TEXT NOT NULL,
    "nama" TEXT NOT NULL,
    "saldo" INTEGER NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "rekening_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "transaksi" (
    "id" TEXT NOT NULL,
    "id_user" TEXT NOT NULL,
    "id_rekening" TEXT NOT NULL,
    "id_kategori" TEXT NOT NULL,
    "id_utang" TEXT,
    "id_parent" TEXT,
    "tipe" TEXT NOT NULL,
    "nominal" INTEGER NOT NULL,
    "nama" TEXT NOT NULL,
    "catatan" TEXT,
    "waktu" TIMESTAMP(3) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "transaksi_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "utang" (
    "id" TEXT NOT NULL,
    "id_user" TEXT NOT NULL,
    "tipe" TEXT NOT NULL,
    "nama" TEXT NOT NULL,
    "saldo" INTEGER NOT NULL,
    "saldo_dibayar" INTEGER NOT NULL,
    "status" TEXT NOT NULL,
    "jatuh_tempo" TIMESTAMP(3) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "utang_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "user_email_key" ON "user"("email");

-- AddForeignKey
ALTER TABLE "master_default_kategori_transaksi" ADD CONSTRAINT "master_default_kategori_transaksi_id_icon_fkey" FOREIGN KEY ("id_icon") REFERENCES "master_icon_transaction"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "kategori_transaksi" ADD CONSTRAINT "kategori_transaksi_id_user_fkey" FOREIGN KEY ("id_user") REFERENCES "user"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "kategori_transaksi" ADD CONSTRAINT "kategori_transaksi_id_icon_fkey" FOREIGN KEY ("id_icon") REFERENCES "master_icon_transaction"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "rekening" ADD CONSTRAINT "rekening_id_user_fkey" FOREIGN KEY ("id_user") REFERENCES "user"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "rekening" ADD CONSTRAINT "rekening_id_kategori_fkey" FOREIGN KEY ("id_kategori") REFERENCES "master_rekening_kategori"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "rekening" ADD CONSTRAINT "rekening_id_icon_fkey" FOREIGN KEY ("id_icon") REFERENCES "master_icon_rekening"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "transaksi" ADD CONSTRAINT "transaksi_id_user_fkey" FOREIGN KEY ("id_user") REFERENCES "user"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "transaksi" ADD CONSTRAINT "transaksi_id_rekening_fkey" FOREIGN KEY ("id_rekening") REFERENCES "rekening"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "transaksi" ADD CONSTRAINT "transaksi_id_kategori_fkey" FOREIGN KEY ("id_kategori") REFERENCES "kategori_transaksi"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "transaksi" ADD CONSTRAINT "transaksi_id_utang_fkey" FOREIGN KEY ("id_utang") REFERENCES "utang"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "transaksi" ADD CONSTRAINT "transaksi_id_parent_fkey" FOREIGN KEY ("id_parent") REFERENCES "transaksi"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "utang" ADD CONSTRAINT "utang_id_user_fkey" FOREIGN KEY ("id_user") REFERENCES "user"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
