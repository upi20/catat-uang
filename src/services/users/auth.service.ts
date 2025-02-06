import prisma from "../../prisma/prisma";
import bcrypt from "bcrypt";
import jwt from "jsonwebtoken";
import dotenv from "dotenv";

dotenv.config();

const SECRET_KEY: string = process.env.JWT_SECRET as string;
const TOKEN_EXPIRES: string = process.env.JWT_EXPIRES || "1h";

// Register User
export const registerUserService = async (
  username: string,
  email: string,
  password: string,
  pin: string
) => {
  // Periksa apakah email sudah digunakan
  const existingUser = await prisma.user.findUnique({ where: { email } });
  if (existingUser) {
    throw new Error("Email already exists");
  }

  // Hash password dan PIN
  const hashedPassword = await bcrypt.hash(password, 10);
  const hashedPin = await bcrypt.hash(pin, 10);

  // Buat user baru
  const newUser = await prisma.user.create({
    data: {
      username,
      email,
      password: hashedPassword,
      role: "user",
      saldo: 0,
      ccy: "IDR",
      pin: hashedPin,
    },
    select: {
      id: true,
      username: true,
      email: true,
      role: true,
      saldo: true,
      ccy: true,
    },
  });

  return newUser;
};

// Login User
export const loginUserService = async (email: string, password: string) => {
  // Cari user berdasarkan email
  const user = await prisma.user.findUnique({ where: { email } });
  if (!user || user.role !== "user") {
    throw new Error("Invalid credentials");
  }

  // Verifikasi password
  const isValidPassword = await bcrypt.compare(password, user.password);
  if (!isValidPassword) {
    throw new Error("Invalid credentials");
  }

  // Buat token JWT
  const token = jwt.sign(
    { id: user.id, email: user.email, role: user.role },
    SECRET_KEY,
    // { expiresIn: TOKEN_EXPIRES }
  );

  return { message: "Login successful", token };
};
