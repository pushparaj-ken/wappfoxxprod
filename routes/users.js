var express = require('express');
var router = express.Router();

const UsersControllers = require('../controllers/usercontrollers');
const Auth = require('../middleware/auth');
const multer = require("multer");

const upload = multer({});

router.post('/login', UsersControllers.LoginDetails);

router.post('/register', UsersControllers.RegisterDetails);

router.put('/password', Auth.AuthMiddleware, UsersControllers.Password);

router.post('/sendemail', UsersControllers.SendEmail);

router.put('/verifyemail', UsersControllers.VerifyEmail);

router.post('/verify', UsersControllers.VerficationCode);

router.get('/profile', Auth.AuthMiddleware, UsersControllers.ProfileDetails);

router.put('/updateprofile', Auth.AuthMiddleware, UsersControllers.UpdateProfileDetails);

router.post('/imageupload', upload.fields([{ name: 'image', maxCount: 1 }]), UsersControllers.CommonImageUpload);

module.exports = router;
