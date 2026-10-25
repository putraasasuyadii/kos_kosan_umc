const express = require('express');
const router = express.Router();
const kosController = require('../controllers/kosController');
const { verifyToken, authorizeRole } = require('../middleware/authMiddleware');

router.get('/', kosController.getAllKos);
router.get('/:id', kosController.getKosById);
router.post('/', verifyToken, authorizeRole('pemilik'), kosController.createKos);
router.put('/:id', verifyToken, authorizeRole('pemilik'), kosController.updateKos);
router.delete('/:id', verifyToken, authorizeRole('pemilik'), kosController.deleteKos);

module.exports = router;