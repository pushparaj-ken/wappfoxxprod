var express = require('express');
var router = express.Router();

const DamageControllers = require('../controllers/damagecontrollers');
const Auth = require('../middleware/auth');
const multer = require("multer");

const upload = multer({});

router.post('/add', Auth.AuthMiddleware, upload.fields([{ name: 'categoryimage', maxCount: 1 }, { name: 'partyinvoleimage', maxCount: 1 }, { name: 'image', maxCount: 1 }]), DamageControllers.AddDamage);

router.get('/list', Auth.AuthMiddleware, DamageControllers.DamageDetails);


module.exports = router;