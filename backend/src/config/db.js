require("dotenv").config();
const mysql = require("mysql2");

const pool = mysql.createPool({
  host    : process.env.DB_HOST,
  port    : process.env.DB_PORT,
  user    : process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
  ssl     : { rejectUnauthorized: false }, // Wajib untuk koneksi Aiven
  waitForConnections: true,
  connectionLimit   : 10,
  queueLimit        : 0,
});

const promisePool = pool.promise();

const testConnection = async () => {
  try {
    const connection = await promisePool.getConnection();
    console.log(`✅ Koneksi database berhasil! (DB: ${process.env.DB_NAME})`);
    connection.release();
  } catch (error) {
    console.error("❌ Koneksi database GAGAL:", error.message);
    process.exit(1);
  }
};

module.exports = { promisePool, testConnection };