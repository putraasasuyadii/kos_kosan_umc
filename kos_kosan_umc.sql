-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 12 Jul 2026 pada 11.48
-- Versi server: 10.4.32-MariaDB
-- Versi PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `kos_kosan_umc`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `kamar`
--

CREATE TABLE `kamar` (
  `id_kamar` int(11) NOT NULL,
  `nomor_kamar` varchar(10) NOT NULL,
  `tipe_kamar` varchar(50) DEFAULT NULL,
  `harga_per_bulan` decimal(10,2) DEFAULT NULL,
  `status` enum('tersedia','terisi') DEFAULT 'tersedia'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `kamar`
--

INSERT INTO `kamar` (`id_kamar`, `nomor_kamar`, `tipe_kamar`, `harga_per_bulan`, `status`) VALUES
(1, 'A01', 'Standar', 500000.00, 'tersedia');

-- --------------------------------------------------------

--
-- Struktur dari tabel `kos_listings`
--

CREATE TABLE `kos_listings` (
  `id` int(11) NOT NULL,
  `pemilik_id` int(11) NOT NULL,
  `nama_kos` varchar(200) NOT NULL,
  `harga` decimal(12,0) NOT NULL,
  `alamat` text NOT NULL,
  `kota` varchar(100) NOT NULL DEFAULT 'Cirebon',
  `tipe` enum('putra','putri','campur') NOT NULL DEFAULT 'campur',
  `deskripsi` text DEFAULT NULL,
  `status` enum('tersedia','penuh') NOT NULL DEFAULT 'tersedia',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `kos_listings`
--

INSERT INTO `kos_listings` (`id`, `pemilik_id`, `nama_kos`, `harga`, `alamat`, `kota`, `tipe`, `deskripsi`, `status`, `created_at`, `updated_at`) VALUES
(1, 2, 'Kos Melati Indah', 800000, 'Jl. Siliwangi No. 12, Cirebon', 'Cirebon', 'putri', 'Kos bersih, dekat kampus UMC, ada WiFi dan dapur bersama.', 'penuh', '2026-07-10 04:11:15', '2026-07-10 05:50:54'),
(2, 2, 'Kos Melati Indah', 750000, 'Jl. Siliwangi No. 12, Cirebon', 'Cirebon', 'putri', 'Kos bersih, dekat kampus UMC, ada WiFi dan dapur bersama.', 'tersedia', '2026-07-10 05:37:38', '2026-07-10 05:37:38');

-- --------------------------------------------------------

--
-- Struktur dari tabel `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `email` varchar(150) NOT NULL,
  `password` text NOT NULL,
  `role` enum('penyewa','pemilik') NOT NULL DEFAULT 'penyewa',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `users`
--

INSERT INTO `users` (`id`, `nama`, `email`, `password`, `role`, `created_at`) VALUES
(1, 'Budi Santoso', 'budi@email.com', '$2a$10$frCyQOQGfJrB7t.rsG3U0ef0Ohar4RiKqe33Bstigj2yGrTAVq1Xi', 'penyewa', '2026-07-09 15:59:28'),
(2, 'Bapak Kos', 'bapakkos@gmail.com', '$2a$10$tRIj/K4hodl6czPqNkbSvOEoUU6OsJS/yKJNhhhEK.9I92g1JvP7m', 'pemilik', '2026-07-10 04:08:30');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `kamar`
--
ALTER TABLE `kamar`
  ADD PRIMARY KEY (`id_kamar`);

--
-- Indeks untuk tabel `kos_listings`
--
ALTER TABLE `kos_listings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `pemilik_id` (`pemilik_id`);

--
-- Indeks untuk tabel `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `kamar`
--
ALTER TABLE `kamar`
  MODIFY `id_kamar` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT untuk tabel `kos_listings`
--
ALTER TABLE `kos_listings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT untuk tabel `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `kos_listings`
--
ALTER TABLE `kos_listings`
  ADD CONSTRAINT `kos_listings_ibfk_1` FOREIGN KEY (`pemilik_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
