const express = require("express");
const cors = require("cors");
const fs = require("fs");
const path = require("path");

const app = express();
const PORT = 3001;
const DATA_FILE = path.join(__dirname, "..", "data", "mcu.json");
const TOKEN_FILE = path.join(__dirname, ".admin-token");

// Read token from file
function getToken() {
  try {
    return fs.readFileSync(TOKEN_FILE, "utf8").trim();
  } catch (e) {
    return "starkverse-admin-2026";
  }
}

app.use(cors());
app.use(express.json({ limit: "5mb" }));

// Auth middleware
function auth(req, res, next) {
  const authHeader = req.headers.authorization;
  if (!authHeader || !authHeader.startsWith("Bearer ")) {
    return res.status(401).json({ error: "Unauthorized" });
  }
  const token = authHeader.slice(7);
  if (token !== getToken()) {
    return res.status(401).json({ error: "Invalid token" });
  }
  next();
}

// GET /api/data — return MCU data
app.get("/api/data", function (req, res) {
  try {
    const data = JSON.parse(fs.readFileSync(DATA_FILE, "utf8"));
    res.json(data);
  } catch (e) {
    res.status(500).json({ error: "Failed to read data" });
  }
});

// PUT /api/data — update MCU data (auth required)
app.put("/api/data", auth, function (req, res) {
  try {
    const data = req.body;
    if (!Array.isArray(data)) {
      return res.status(400).json({ error: "Data must be an array" });
    }
    fs.writeFileSync(DATA_FILE, JSON.stringify(data, null, 2), "utf8");
    res.json({ success: true, count: data.length });
  } catch (e) {
    res.status(500).json({ error: "Failed to save data" });
  }
});

// GET /api/auth — check auth status
app.get("/api/auth", function (req, res) {
  const authHeader = req.headers.authorization;
  if (!authHeader || !authHeader.startsWith("Bearer ")) {
    return res.json({ authenticated: false });
  }
  const token = authHeader.slice(7);
  res.json({ authenticated: token === getToken() });
});

// GET /api/posters — list available poster files
app.get("/api/posters", function (req, res) {
  const postersDir = path.join(__dirname, "..", "assets", "posters");
  try {
    const files = fs.readdirSync(postersDir).filter(function (f) {
      return /\.(jpg|jpeg|png|webp)$/i.test(f);
    });
    res.json(files);
  } catch (e) {
    res.json([]);
  }
});

app.listen(PORT, "127.0.0.1", function () {
  console.log("STARKVERSE CMS API running on port " + PORT);
});
