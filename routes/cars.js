var express = require('express');
var router = express.Router();

const CarsControllers = require('../controllers/carscontrollers');
const Auth = require('../middleware/auth');


router.get('/list', Auth.AuthMiddleware, CarsControllers.CarsList);

router.post('/carkmstand', Auth.AuthMiddleware, CarsControllers.CarkmStand);

module.exports = router;
