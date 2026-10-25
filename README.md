# 🏠 KosKu — Aplikasi Direktori Kos-kosan UMC

Aplikasi web direktori kos-kosan untuk mahasiswa Universitas Muhammadiyah Cirebon (UMC).

## 👥 Tim Pengembang
- Putra Asa Suyadi 240511049

## 🛠️ Tech Stack
- **Frontend** : React.js + Tailwind CSS + Vite
- **Backend**  : Node.js + Express.js
- **Database** : MySQL

## ✅ Fitur
- Register & Login (Penyewa & Pemilik Kos)
- Lihat daftar kos dengan filter
- Halaman detail kos
- Dashboard pemilik (tambah & hapus kos)
- Pencarian berdasarkan kota & tipe

## 🚀 Cara Menjalankan

### Persiapan Database
1. Buat database MySQL bernama `kos_kosan_umc`
2. Import file `kos_kosan_umc.sql`

### Backend
```bash
cd backend
npm install
npm run dev
# Server berjalan di http://localhost:5000
```

### Frontend
```bash
cd frontend
npm install
npm run dev
# Aplikasi berjalan di http://localhost:5173
```

## ⚙️ Environment Variables

Buat file `.env` di folder `backend/`:
```env
PORT=5000
DB_HOST=localhost
DB_USER=root
DB_PASSWORD=
DB_NAME=kos_kosan_umc
JWT_SECRET=rahasia_panjang_kalian
JWT_EXPIRES_IN=7d
```