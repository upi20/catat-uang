import prisma from "../../prisma/prisma";

// Ambil data profil user berdasarkan ID
export const getUserProfileService = async (userId: string) => {
  const user = await prisma.user.findUnique({
    where: { id: userId },
    select: { id: true, username: true, email: true, saldo: true, ccy: true },
  });

  if (!user) {
    throw new Error("User not found");
  }

  return user;
};

// Perbarui profil user (username dan email)
export const updateUserProfileService = async (
  userId: string,
  username: string,
  email: string
) => {
  // Cek apakah email sudah digunakan oleh user lain
  const existingUser = await prisma.user.findFirst({
    where: { email, NOT: { id: userId } },
  });

  if (existingUser) {
    throw new Error("Email already in use");
  }

  const updatedUser = await prisma.user.update({
    where: { id: userId },
    data: { username, email },
    select: { id: true, username: true, email: true },
  });

  return updatedUser;
};

// Perbarui saldo user
export const updateUserSaldoService = async (userId: string, saldo: number) => {
  const updatedUser = await prisma.user.update({
    where: { id: userId },
    data: { saldo },
    select: { id: true, saldo: true, ccy: true },
  });

  return updatedUser;
};
