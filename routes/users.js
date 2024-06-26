var express = require('express');
var router = express.Router();

const UsersControllers = require('../controllers/usercontrollers');
const Auth = require('../middleware/auth');


router.post('/login', UsersControllers.LoginDetails);

router.post('/register', UsersControllers.RegisterDetails);

router.put('/password', Auth.AuthMiddleware, UsersControllers.Password);

router.post('/sendemail', UsersControllers.SendEmail);

router.put('/verifyemail', UsersControllers.VerifyEmail);

router.post('/verify', UsersControllers.VerficationCode);

router.get('/profile', Auth.AuthMiddleware, UsersControllers.ProfileDetails);

router.put('/updateprofile', Auth.AuthMiddleware, UsersControllers.UpdateProfileDetails);

module.exports = router;
