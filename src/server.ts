import express, { Application } from "express";
import dotenv from "dotenv";
import cors from "cors";
import routes from "./routes";

dotenv.config();

const app: Application = express();

app.use(cors());
app.use(express.json());

// Prefix API
app.use("/api", routes);

// Endpoint default
app.get("/", (req, res) => {
  res.send("Backend Catat Uang is Running");
});

// Export handler untuk Vercel
export default app;
