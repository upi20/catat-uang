import { Router } from "express";
import {
  getUserProfile,
  updateUserProfile,
  updateUserSaldo,
} from "../controllers/users/profile.controller";
import { authenticateJWT } from "../middleware/auth";

const router = Router();

// Get user profile
router.get("/profile", authenticateJWT, getUserProfile);

// Update user profile
router.put("/profile", authenticateJWT, updateUserProfile);

// Update user saldo
router.put("/saldo", authenticateJWT, updateUserSaldo);

export default router;
