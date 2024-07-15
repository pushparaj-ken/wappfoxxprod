var express = require('express');
var router = express.Router();

const CustomersControllers = require('../controllers/customerscontrollers');
const Auth = require('../middleware/auth');


router.post('/add', Auth.AuthMiddleware, CustomersControllers.AddCustomers);

router.get('/list', Auth.AuthMiddleware, CustomersControllers.ListCustomers);

router.put('/update/:id', Auth.AuthMiddleware, CustomersControllers.UpdateCustomersDetails);

router.delete('/delete/:id', Auth.AuthMiddleware, CustomersControllers.DeleteCustomersDetails);

module.exports = router;