
const express = require('express');
const path = require('path');
const cookieParser = require('cookie-parser');
const logger = require('morgan');
const cors = require('cors');
const dotenv = require('dotenv');
dotenv.config();
const errorHandler = require('./utils/ApiError');
//const indexRouter = require('./routes/index');
const AdminRouter = require('./routes/adminusers');
const usersRouter = require('./routes/users');
const carsRouter = require('./routes/cars');
const VehicleRouter = require('./routes/vehicle');
const DamageRouter = require('./routes/damage');
const customersRouter = require('./routes/customers');
const driverRouter = require('./routes/driver');

const { generateSwagger, serveSwagger } = require('./swagger/swagger');

var app = express();

const routes = ['./swagger/users/*.js']; // Specify the path to your route files

const routesadmin = ['./swagger/admin/*.js']; // Specify the path to your route files

// Generate Swagger documentation
const swaggerSpec = generateSwagger('Consense', '1.0.0', routes);
//console.log(swaggerSpec);
const swaggerSpecAdmin = generateSwagger('Consense Admin', '1.0.0', routesadmin);

// Serve Swagger documentation
serveSwagger(app, swaggerSpec, '/api-docs');

serveSwagger(app, swaggerSpecAdmin, '/api/admin/docs');

// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'pug');

app.use(cors({
  origin: ['http://localhost:3000', 'https://demo1.smcreativemedia.in', 'https://consense.wappfoxx.de', 'http://consense.wappfoxx.de']
}));

app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));

app.use(errorHandler);

//Routes
//app.use('/api/Bankverbindungen', indexRouter);

app.use('/api/admin', AdminRouter);
app.use('/api/users', usersRouter);
app.use('/api/cars', carsRouter);
app.use('/api/vehicle', VehicleRouter);
app.use('/api/damage', DamageRouter);
app.use('/api/admin/customers', customersRouter);
app.use('/api/admin/driver', driverRouter);


// catch 404 and forward to error handler
app.use(function (req, res, next) {
  const errcode = new Error("Not Found.");
  errcode.statusCode = 404;
  console.log("TCL: err", 404)
  return next(errcode);
});

app.use(function (err, req, res, next) {
  const statusCode = err.statusCode || 500;
  return res.status(statusCode).json({
    success: false,
    code: statusCode,
    message: err.message || 'Internal Server Error',
    timestamp: new Date()
  });
});

module.exports = app;
