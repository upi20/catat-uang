import { Router } from "express";
import userAuthRoutes from "./user.auth.routes";
import userProfileRoutes from "./user.profile.routes";

const router = Router();

// Gunakan versi API dalam route
const API_VERSION = "/v1";

router.use(`${API_VERSION}/user`, userAuthRoutes);
router.use(`${API_VERSION}/user`, userProfileRoutes);

// Placeholder untuk admin (nanti akan ditambahkan)
router.use(`${API_VERSION}/admin`, (req, res) => {
  res.status(501).json({ message: "Admin routes not implemented yet" });
});

export default router;
