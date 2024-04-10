/*
  Warnings:

  - You are about to drop the column `addressId` on the `User` table. All the data in the column will be lost.

*/
-- DropForeignKey
ALTER TABLE "User" DROP CONSTRAINT "User_addressId_fkey";

-- AlterTable
ALTER TABLE "Order" ADD COLUMN     "addressId" INTEGER;

-- AlterTable
ALTER TABLE "User" DROP COLUMN "addressId";

-- AddForeignKey
ALTER TABLE "Order" ADD CONSTRAINT "Order_addressId_fkey" FOREIGN KEY ("addressId") REFERENCES "Address"("id") ON DELETE SET NULL ON UPDATE CASCADE;
