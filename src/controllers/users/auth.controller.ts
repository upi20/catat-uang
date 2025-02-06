import { Request, Response } from "express";
import {
  registerUserService,
  loginUserService,
} from "../../services/users/auth.service";
import { successResponse, errorResponse } from "../../utils/apiResponse";

// Registrasi User
export const registerUser = async (req: Request, res: Response) => {
  try {
    const { username, email, password, pin } = req.body;

    if (!username || !email || !password || !pin) {
      errorResponse(res, 400, "All fields are required");
      return;
    }

    const newUser = await registerUserService(username, email, password, pin);
    successResponse(res, 201, "User registered successfully", newUser);
    return;
  } catch (error: any) {
    errorResponse(res, 400, error.message);
    return;
  }
};

// Login User
export const loginUser = async (req: Request, res: Response) => {
  try {
    const { email, password } = req.body;

    if (!email || !password) {
      errorResponse(res, 400, "Email and password are required");
      return;
    }

    const result = await loginUserService(email, password);
    successResponse(res, 200, "Login successful", result);
    return;
  } catch (error: any) {
    errorResponse(res, 401, error.message);
    return;
  }
};
