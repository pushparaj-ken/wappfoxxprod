const catchAsync = require('../utils/catchAsync');
const Auth = require('../services/token');
const _ = require('lodash');
const emailError = require('../services/email')
const prisma = require('../db/prisma-client/prisma.service');
const bcrypt = require("bcryptjs");


const LoginDetails = catchAsync(async (req, res, next) => {
  try {
    const values = req.body
    if (values.EMailAdresse != '' && values.EMailAdresse != null && values.EMailAdresse != undefined && values.Passwort != '' && values.Passwort != null && values.Passwort != undefined) {
      const AdministratorinDetails = await prisma.administratorin.findUnique({ where: { EMailAdresse: values.EMailAdresse } })
      console.log("🚀 ~ LoginDetails ~ AdministratorinDetails:", AdministratorinDetails)
      if (AdministratorinDetails != null) {
        const id = AdministratorinDetails.Id;
        const token = Auth.getJWTToken(id, "Admin")
        console.log(token)
        res.set('Authentication', token);
        res.cookie('Authentication', token, { httpOnly: true, secure: true, maxAge: 3600000 });
        console.log('Response Header Authentication:', res.get('Authentication'));
        console.log('Response Header Authentication:', res.get('Set-Cookie'));
        const isPasswordMatched = bcrypt.compare(values.Passwort, AdministratorinDetails.Passwort);
        if (!isPasswordMatched) {
          const errcode = new Error("Password mismatch");
          errcode.statusCode = 201;
          return next(errcode);
        } else {
          const sanitizedUserDetails = _.omit(AdministratorinDetails, ['Passwort']);
          res.send({
            success: true,
            code: 200,
            Data: sanitizedUserDetails,
            status: "Login Successfully",
            token: token
          });
          //console.log(res)
        }
      } else {
        const errcode = new Error("Email or Password mismatch");
        errcode.statusCode = 201;
        return next(errcode);
      }
    } else {
      const errcode = new Error("All Field are Mandatory");
      errcode.statusCode = 201;
      return next(errcode);
    }
  } catch (error) {
    console.log("TCL: getBankverbindungen -> error", error)
    const errcode = new Error(error.stack);
    errcode.statusCode = 201;
    return next(errcode);
  }
});

const RegisterDetails = catchAsync(async (req, res, next) => {
  try {
    const values = req.body
    if (values.EMailAdresse && values.Vorname && values.Telefonnummer && values.EMailAdresse.trim() !== '' && values.Vorname.trim() !== '') {
      const dministratorinDetails = await prisma.administratorin.findUnique({ where: { EMailAdresse: values.EMailAdresse } });
      if (dministratorinDetails != null) {
        const errcode = new Error("Email Already Exists");
        errcode.statusCode = 201;
        return next(errcode);
      } else {
        values.Passwort = await bcrypt.hash(values.Passwort, 10);
        values.Telefonnummer = (values.Telefonnummer).toString();
        const UsersDetails = await prisma.administratorin.create({ data: values });
        if (UsersDetails) {
          const id = UsersDetails.Id;
          const token = Auth.getJWTToken(id, "Admin")
          const sanitizedUserDetails = _.omit(UsersDetails, ['Passwort']);
          res.set('Authentication', token);
          res.cookie('Authentication', token, { httpOnly: true, secure: true, maxAge: 3600000 });
          res.send({
            success: true,
            code: 200,
            status: "Register Successfully",
            timestamp: new Date(),
            data: sanitizedUserDetails,
            token: token
          });
        } else {
          const errcode = new Error("No Records Found");
          errcode.statusCode = 201;
          return next(errcode);
        }
      }
    } else {
      const errcode = new Error("All Field are Mandatory");
      errcode.statusCode = 201;
      return next(errcode);
    }

  } catch (error) {
    console.log("TCL: getBankverbindungen -> error", error)
    const errcode = new Error(error.message);
    errcode.statusCode = 201;
    return next(errcode);
  }
});

const DashboardDetails = catchAsync(async (req, res, next) => {
  try {
    let values = req.query
    const CustomersDetails = await prisma.kunden.findMany();
    const DriverDetails = await prisma.benutzer.findMany();
    let Data = {
      CustomerCount: CustomersDetails.length,
      DriverCount: DriverDetails.length
    }
    if (Data) {
      res.send({
        success: true,
        code: 200,
        status: "Data Retrieved successfully",
        timestamp: new Date(),
        data: Data
      });
    } else {
      const errcode = new Error("No Records Found");
      errcode.statusCode = 201;
      return next(errcode);
    }
  } catch (error) {
    console.log("🚀 ~ DashboardDetails ~ error:", error.stack)
    const errcode = new Error(error.stack);
    errcode.statusCode = 201;
    return next(errcode);
  }
});

const SendEmail = catchAsync(async (req, res, next) => {
  try {
    const values = req.body
    if (values.EMailAdresse && values.EMailAdresse.trim() !== '') {
      const code = Math.floor(100000 + Math.random() * 900000);
      let content = "Email Verification code " + code;
      const EmailResponse = await emailError.sendEmail(values.EMailAdresse, "Email Verification Consense", content);
      if (EmailResponse.code === 200) {
        const data = {
          EmailCode: code
        }
        const where = { EMailAdresse: values.EMailAdresse }
        await prisma.benutzers.update({ data, where });
        res.send({
          success: true,
          code: 200,
          status: "Email Send Successfully",
          timestamp: new Date(),
        });
      } else {
        const errcode = new Error(EmailResponse.status);
        errcode.statusCode = 201;
        return next(errcode);
      }
    } else {
      const errcode = new Error("All Field are Mandatory");
      errcode.statusCode = 201;
      return next(errcode);
    }
  } catch (error) {
    console.log("TCL: getBankverbindungen -> error", error)
    const errcode = new Error(error.stack);
    errcode.statusCode = 201;
    return next(errcode);
  }
});

const VerifyEmail = catchAsync(async (req, res, next) => {
  try {
    const values = req.body
    if (values.EMailAdresse != '' && values.EMailAdresse != null && values.EMailAdresse != undefined && values.code !== '' && values.code !== null && values.code !== undefined) {
      const existingRecord = await prisma.benutzers.findUnique({ where: { EMailAdresse: values.EMailAdresse } });
      if (existingRecord) {
        if (existingRecord.EmailCode === values.code) {
          let data = {
            IsEmail: true
          }
          await prisma.benutzers.update({ data, where: { EMailAdresse: values.EMailAdresse } });
          res.send({
            success: true,
            code: 200,
            status: "Verified Successfully",
            timestamp: new Date(),
          });
        } else {
          const errcode = new Error("Verfication Code is Invalid");
          errcode.statusCode = 201;
          return next(errcode);
        }
      } else {
        const errcode = new Error("Driver not Found");
        errcode.statusCode = 201;
        return next(errcode);
      }

    } else {
      const errcode = new Error("Id required to Update Password.");
      errcode.statusCode = 201;
      return next(errcode);
    }

  } catch (error) {
    console.log("TCL: getBankverbindungen -> error", error)
    const errcode = new Error(error.stack);
    errcode.statusCode = 201;
    return next(errcode);
  }
});

const DamageDetails = catchAsync(async (req, res, next) => {
  try {
    const users = req.user;
    const values = req.query;
    let where = {}
    let query = {}
    if (values.damageNo != null && values.damageNo != undefined && values.damageNo != '') {
      where.damageNo = values.damageNo
    }
    if (values.userId != null && values.userId != undefined && values.userId != '') {
      where.userId = parseInt(values.userId)
    }

    query = { where, include: { parkinglocation: true, documents: true, policedetails: true, partydetails: true, damagevehicleparts: true } }
    const damageDetails = await prisma.damage.findMany(query)
    if (damageDetails.length > 0) {
      res.send({
        success: true,
        code: 200,
        status: "Data Retrieved Success",
        Data: damageDetails,
        timestamp: new Date(),
      });
    } else {
      const errcode = new Error("No Data exists.");
      errcode.statusCode = 201;
      return next(errcode);
    }
  } catch (error) {
    console.log("TCL: getBankverbindungen -> error", error)
    const errcode = new Error(error.stack);
    errcode.statusCode = 201;
    return next(errcode);
  }
});


module.exports = {
  LoginDetails,
  RegisterDetails,
  DashboardDetails,
  SendEmail,
  VerifyEmail,
  DamageDetails,
}