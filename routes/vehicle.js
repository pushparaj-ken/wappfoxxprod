var express = require('express');
var router = express.Router();

const VehicleControllers = require('../controllers/vehiclecontrollers');
const Auth = require('../middleware/auth');


router.get('/list', Auth.AuthMiddleware, VehicleControllers.VehicleList);


module.exports = router;