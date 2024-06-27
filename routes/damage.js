var express = require('express');
var router = express.Router();

const DamageControllers = require('../controllers/damagecontrollers');
const Auth = require('../middleware/auth');


router.post('/add', Auth.AuthMiddleware, DamageControllers.AddDamage);


module.exports = router;