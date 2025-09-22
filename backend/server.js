import express from "express";
import mysql from "mysql2";
import cors from "cors";

const app = express();
app.use(cors());

// koneksi ke database
const db = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "",
  database: "budget_hmmi"
});

// endpoint API ambil data
app.get("/api/data", (req, res) => {
  db.query("SELECT * FROM budget_mat", (err, results) => {
    if (err) return res.json({ error: err });
    res.json(results);
  });
});

app.listen(5000, () => {
  console.log("Server berjalan di http://localhost:5000");
});
