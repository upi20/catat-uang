import { Request, Response, NextFunction } from "express";
import jwt from "jsonwebtoken";
import dotenv from "dotenv";

dotenv.config();

const SECRET_KEY = process.env.JWT_SECRET as string;

export const authenticateJWT = (
  req: Request,
  res: Response,
  next: NextFunction
): void => {
  const authHeader = req.header("Authorization");

  if (!authHeader || !authHeader.startsWith("Bearer ")) {
    res.status(401).json({ error: "Access denied. No token provided." });
  } else {
    let token = authHeader.split(" ")[1];

    if (!token) {
      res.status(401).json({ error: "Invalid token format." });
    } else {
      try {
        const decoded = jwt.verify(token, SECRET_KEY) as {
          id: string;
          email: string;
          role: string;
        };
        (req as any).user = decoded;
        next(); // Hanya jika token valid, lanjut ke handler berikutnya
      } catch (error) {
        res.status(403).json({ error: "Invalid or expired token." });
      }
    }
  }
};
