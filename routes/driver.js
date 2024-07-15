var express = require('express');
var router = express.Router();

const DriverControllers = require('../controllers/drivercontrollers');
const Auth = require('../middleware/auth');



router.post('/add', Auth.AuthMiddleware, DriverControllers.AddDriver);

router.get('/list', Auth.AuthMiddleware, DriverControllers.ListDriver);

router.put('/update/:id', Auth.AuthMiddleware, DriverControllers.UpdateDriverDetails);

router.delete('/delete/:id', Auth.AuthMiddleware, DriverControllers.DeleteDriverDetails);

module.exports = router;