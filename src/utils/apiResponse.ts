import { Response } from "express";

// Fungsi untuk mengirim respons sukses
export const successResponse = (
  res: Response,
  statusCode: number,
  message: string | null,
  data: any = null
): void => {
  res.status(statusCode).json({
    status: statusCode,
    message,
    data,
  });
};

// Fungsi untuk mengirim respons error
export const errorResponse = (
  res: Response,
  statusCode: number,
  message: string | null,
  data: any = null
): void => {
  res.status(statusCode).json({
    status: statusCode,
    message,
    data,
  });
};
