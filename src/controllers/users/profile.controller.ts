import { Request, Response } from "express";
import {
  getUserProfileService,
  updateUserProfileService,
  updateUserSaldoService,
} from "../../services/users/profile.service";
import { successResponse, errorResponse } from "../../utils/apiResponse";

// Ambil data profil user
export const getUserProfile = async (req: Request, res: Response) => {
  try {
    const userId = (req as any).user.id;
    const user = await getUserProfileService(userId);
    successResponse(res, 200, "Profile fetched successfully", user);
    return;
  } catch (error: any) {
    errorResponse(res, 404, error.message);
    return;
  }
};

// Perbarui profil user
export const updateUserProfile = async (req: Request, res: Response) => {
  try {
    const userId = (req as any).user.id;
    const { username, email } = req.body;

    if (!username || !email) {
      errorResponse(res, 400, "Username and email are required");
      return;
    }

    const updatedUser = await updateUserProfileService(userId, username, email);
    successResponse(res, 200, "Profile updated successfully", updatedUser);
    return;
  } catch (error: any) {
    errorResponse(res, 400, error.message);
    return;
  }
};

// Perbarui saldo user
export const updateUserSaldo = async (req: Request, res: Response) => {
  try {
    const userId = (req as any).user.id;
    const { saldo } = req.body;

    if (saldo === undefined || saldo < 0) {
      errorResponse(res, 400, "Saldo must be a positive number");
      return;
    }

    const updatedUser = await updateUserSaldoService(userId, saldo);
    successResponse(res, 200, "Saldo updated successfully", updatedUser);
    return;
  } catch (error: any) {
    errorResponse(res, 400, error.message);
    return;
  }
};
