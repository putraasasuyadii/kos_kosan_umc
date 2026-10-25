const { promisePool } = require('../config/db');

// GET Semua Kos — mendukung filter query: ?kota=&tipe=&harga=
exports.getAllKos = async (req, res) => {
    try {
        const { kota, tipe, harga } = req.query;

        // Bangun query dinamis berdasarkan filter yang dikirim
        let sql    = 'SELECT * FROM kos_listings WHERE 1=1';
        const params = [];

        if (kota) {
            sql += ' AND kota LIKE ?';
            params.push(`%${kota}%`);
        }
        if (tipe) {
            sql += ' AND tipe = ?';
            params.push(tipe);
        }
        if (harga) {
            sql += ' AND harga <= ?';
            params.push(Number(harga));
        }

        sql += ' ORDER BY id DESC';

        const [rows] = await promisePool.query(sql, params);
        res.status(200).json({
            status : 'success',
            message: `${rows.length} listing kos ditemukan.`,
            data   : rows,
        });
    } catch (err) {
        res.status(500).json({ status: 'error', message: err.message });
    }
};

// GET Detail Kos by ID
exports.getKosById = async (req, res) => {
    try {
        const [rows] = await promisePool.query(`
            SELECT k.*, u.nama AS nama_pemilik, u.email AS email_pemilik 
            FROM kos_listings k 
            JOIN users u ON k.pemilik_id = u.id 
            WHERE k.id = ?`, [req.params.id]);
        
        if (rows.length === 0) return res.status(404).json({ status: 'error', message: 'Kos tidak ditemukan.' });
        res.status(200).json({ status: 'success', message: 'Detail listing kos berhasil diambil.', data: rows[0] });
    } catch (err) {
        res.status(500).json({ status: 'error', message: err.message });
    }
};

// POST Buat Kos Baru
exports.createKos = async (req, res) => {
    const { nama_kos, harga, alamat, kota, tipe, deskripsi } = req.body;
    const pemilik_id = req.user.id; // Diambil dari verifyToken
    try {
        const [result] = await promisePool.query(
            'INSERT INTO kos_listings (pemilik_id, nama_kos, harga, alamat, kota, tipe, deskripsi) VALUES (?, ?, ?, ?, ?, ?, ?)',
            [pemilik_id, nama_kos, harga, alamat, kota, tipe, deskripsi]
        );
        res.status(201).json({
            status : 'success',
            message: 'Listing kos baru berhasil dibuat!',
            data   : { id: result.insertId, pemilik_id, ...req.body },
        });
    } catch (err) {
        res.status(500).json({ status: 'error', message: err.message });
    }
};

// PUT Update Kos
exports.updateKos = async (req, res) => {
    const { harga, status } = req.body;
    try {
        await promisePool.query(
            'UPDATE kos_listings SET harga = COALESCE(?, harga), status = COALESCE(?, status) WHERE id = ?',
            [harga, status, req.params.id]
        );
        res.status(200).json({
            status : 'success',
            message: 'Listing kos berhasil diperbarui.',
            data   : { id: req.params.id, harga, status },
        });
    } catch (err) {
        res.status(500).json({ status: 'error', message: err.message });
    }
};

// DELETE Kos
exports.deleteKos = async (req, res) => {
    try {
        await promisePool.query('DELETE FROM kos_listings WHERE id = ?', [req.params.id]);
        res.status(200).json({ status: 'success', message: 'Listing kos berhasil dihapus.' });
    } catch (err) {
        res.status(500).json({ status: 'error', message: err.message });
    }
};