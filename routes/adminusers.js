var express = require('express');
var router = express.Router();

const AdminControllers = require('../controllers/admincontrollers');
const Auth = require('../middleware/auth');



router.post('/login', AdminControllers.LoginDetails);

router.post('/register', AdminControllers.RegisterDetails);

router.get('/dashboard', Auth.AuthMiddleware, AdminControllers.DashboardDetails);

router.post('/sendemail', Auth.AuthMiddleware, AdminControllers.SendEmail);

router.put('/verifyemail', Auth.AuthMiddleware, AdminControllers.VerifyEmail);

router.get('/damagelist', Auth.AuthMiddleware, AdminControllers.DamageDetails);


module.exports = router;