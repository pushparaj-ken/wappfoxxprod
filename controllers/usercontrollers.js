const catchAsync = require('../utils/catchAsync');
const Auth = require('../services/token');
const _ = require('lodash');
const emailError = require('../services/email')
const prisma = require('../db/prisma-client/prisma.service');
const bcrypt = require("bcryptjs");
const imageUpload = require("../services/imageupload");


const LoginDetails = catchAsync(async (req, res, next) => {
  try {
    const values = req.body
    if (values.EMailAdresse != '' && values.EMailAdresse != null && values.EMailAdresse != undefined && values.Passwort != '' && values.Passwort != null && values.Passwort != undefined && values.kundencode != '' && values.kundencode != null && values.kundencode != undefined) {
      const kundencodeDeatils = await prisma.kunden.findFirst({ where: { Kundencode: (values.kundencode).toString() } });
      if (kundencodeDeatils != null) {

        const BankverbindungenDetails = await prisma.benutzer.findFirst({
          where: {
            KundeTenantItemId: kundencodeDeatils.TenantItemId,
            Benutzers: {
              EMailAdresse: values.EMailAdresse,
            }
          },
          include: {
            Benutzers: true
          }
        });
        if (BankverbindungenDetails != null) {
          if (kundencodeDeatils.TenantItemId === BankverbindungenDetails.KundeTenantItemId) {
            if (BankverbindungenDetails.Benutzers.IsEmail === true) {
              const id = BankverbindungenDetails.Benutzers.BenutzerId;
              const token = Auth.getJWTToken(id, "Users")
              res.set('Authentication', token);
              const isPasswordMatched = bcrypt.compare(values.Passwort, BankverbindungenDetails.Benutzers.Passwort)
              if (!isPasswordMatched) {
                const errcode = new Error("Password mismatch");
                errcode.statusCode = 201;
                return next(errcode);
              } else {
                let UsersDetails = BankverbindungenDetails.Benutzers
                UsersDetails.KundeTenantItemId = BankverbindungenDetails.KundeTenantItemId
                const sanitizedUserDetails = _.omit(UsersDetails, ['Passwort']);
                res.send({
                  success: true,
                  code: 200,
                  Data: sanitizedUserDetails,
                  status: "Login Successfully",
                });
                //console.log(res)
              }
            } else {
              const errcode = new Error("Email not Verified");
              errcode.statusCode = 210;
              return next(errcode);
            }
          } else {
            const errcode = new Error("Customer Code is Invalid for the Driver");
            errcode.statusCode = 203;
            return next(errcode);
          }
        } else {
          const errcode = new Error("EmailId not Exists");
          errcode.statusCode = 202;
          return next(errcode);
        }
      } else {
        const errcode = new Error("Invalid Customer Code");
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
    if (values.EMailAdresse && values.VorundNachname && values.zugehorigesUnternehmen && values.kundencode && values.EMailAdresse.trim() !== '' && values.VorundNachname.trim() !== '' && values.zugehorigesUnternehmen.trim() !== '' && values.kundencode.trim() !== '') {

      const BankverbindungenDetails = await prisma.benutzers.findUnique({ where: { EMailAdresse: values.EMailAdresse } });
      if (BankverbindungenDetails != null) {
        const errcode = new Error("Email Already Exists");
        errcode.statusCode = 201;
        return next(errcode);
      } else {
        const kundencodeDeatils = await prisma.kunden.findFirst({ where: { Kundencode: values.kundencode } });
        console.log("🚀 ~ RegisterDetails ~ kundencodeDeatils:", kundencodeDeatils)
        const Benutzer = {
          KundeTenantItemId: kundencodeDeatils.TenantItemId
        }
        console.log("🚀 ~ RegisterDetails ~ Benutzer:", Benutzer)
        const Fahrer = {
          KundeTenantItemId: kundencodeDeatils.TenantItemId,
          Nachname: values.VorundNachname,
          Anrede: 1,
        }
        const UsersDetails = await prisma.benutzer.create({ data: Benutzer });
        await prisma.fahrer.create({ data: Fahrer }).then(async (FahrerDetails) => {
          const Adresse = {
            Emailadresse: values.EMailAdresse,
            FahrerId: FahrerDetails.FahrerId,
            Land: '',
            AdressTyp: '',
            AdressVerweis: 0
          }
          await prisma.adresse.create({ data: Adresse });
        })
        if (UsersDetails) {
          const Benutzers = {
            VorundNachname: (values.VorundNachname).slice(0, 10),
            zugehorigesUnternehmen: (values.zugehorigesUnternehmen).slice(0, 10),
            EMailAdresse: values.EMailAdresse,
            UserId: UsersDetails.UserId
          }
          const benutzersDetails = await prisma.benutzers.create({ data: Benutzers });
          const id = benutzersDetails.BenutzerId;
          const token = Auth.getJWTToken(id, "Users")
          const BankverbindungenDetails = await prisma.benutzer.findFirst({
            where: {
              KundeTenantItemId: kundencodeDeatils.TenantItemId,
              Benutzers: {
                EMailAdresse: values.EMailAdresse,
              }
            },
            include: {
              Benutzers: true
            }
          });
          let UsersRegisterDetails = BankverbindungenDetails.Benutzers
          UsersRegisterDetails.KundeTenantItemId = BankverbindungenDetails.KundeTenantItemId
          const sanitizedUserDetails = _.omit(UsersRegisterDetails, ['Passwort']);
          res.set('Authentication', token);
          res.send({
            success: true,
            code: 200,
            status: "Register Successfully",
            timestamp: new Date(),
            data: sanitizedUserDetails,
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


const Password = catchAsync(async (req, res, next) => {
  try {
    const values = req.body
    const users = req.user;
    if (users.BenutzerId != '' && users.BenutzerId != null && users.BenutzerId != undefined) {
      if (values.Passwort && values.cPasswort && values.Passwort.trim() !== '' && values.cPasswort.trim() !== '') {
        if (values.Passwort === values.cPasswort) {
          const existingRecord = await prisma.benutzers.findUnique({ where: { BenutzerId: users.BenutzerId } });
          if (existingRecord) {
            const password = await bcrypt.hash(values.Passwort, 10);
            const data = {
              Passwort: password
            }
            const where = { BenutzerId: users.BenutzerId }
            await prisma.benutzers.update({ data, where });
            res.send({
              success: true,
              code: 200,
              status: "Password Successfully",
              timestamp: new Date(),
            });
          } else {
            const errcode = new Error("Driver not Found");
            errcode.statusCode = 201;
            return next(errcode);
          }

        } else {
          const errcode = new Error("Password and Confirm Password Not match");
          errcode.statusCode = 201;
          return next(errcode);
        }
      } else {
        const errcode = new Error("All Field are Mandatory");
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
          const data = {
            IsEmail: true
          }
          const where = { EMailAdresse: values.EMailAdresse }
          await prisma.benutzers.update({ data, where });
          const id = existingRecord.BenutzerId;
          const token = Auth.getJWTToken(id, "Users")
          console.log(token)
          res.set('Authentication', token);
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

const VerficationCode = catchAsync(async (req, res, next) => {
  try {
    const values = req.body
    if (values.vcode && values.vcode !== '' && values.vcode !== null && values.vcode !== undefined) {
      let vcode = (values.vcode).toString()
      if (vcode.length === 8) {
        const checkvcodeExists = await prisma.kunden.findFirst({ where: { Kundencode: values.vcode } });
        if (checkvcodeExists) {
          res.send({
            success: true,
            code: 200,
            status: "Verified Successfully",
            timestamp: new Date(),
          });
        } else {
          const errcode = new Error("Please enter a valid code");
          errcode.statusCode = 201;
          return next(errcode);
        }
      } else {
        const errcode = new Error("Please enter a 8 digit");
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

const ProfileDetails = catchAsync(async (req, res, next) => {
  try {
    const values = req.body
    const users = req.user;
    if (users.BenutzerId != '' && users.BenutzerId != null && users.BenutzerId != undefined) {
      const existingRecord = await prisma.benutzers.findUnique({
        where: { BenutzerId: users.BenutzerId },
        include: {
          Benutzer: {
            include: {
              Kunden: true
            }
          }
        },
      });
      if (existingRecord) {
        res.send({
          success: true,
          code: 200,
          Data: existingRecord,
          status: "Data Retervived Success",
        });

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

const UpdateProfileDetails = catchAsync(async (req, res, next) => {
  try {
    const values = req.body
    const users = req.user;
    if (users.BenutzerId != '' && users.BenutzerId != null && users.BenutzerId != undefined) {
      const existingRecord = await prisma.benutzers.findUnique({ where: { BenutzerId: users.BenutzerId } });
      if (existingRecord) {
        const data = values
        const where = { BenutzerId: users.BenutzerId }
        await prisma.benutzers.update({ data, where });
        res.send({
          success: true,
          code: 200,
          status: "Data Update Success",
        });
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


const CommonImageUpload = catchAsync(async (req, res) => {
  let values = req.body;
  let files = req.files;

  if (files.image != '' && files.image != null && files.image != undefined

  ) {

    let image_new = "";
    if (files.image) {
      const { buffer, originalname } = files.image[0];
      let image = await imageUpload.upload(buffer, originalname);
      image_new = image.Location;
    } else {
      image_new = image_new;
    }
    res.send({
      success: true,
      code: 200,
      Image_url: image_new,
      Status: "Images Saved Success",
    });

  } else {
    res.send({
      code: 201,
      success: false,
      status: "All Fields are Mandatory",
      timestamp: new Date()
    });
  }
});

module.exports = {
  LoginDetails,
  RegisterDetails,
  SendEmail,
  VerficationCode,
  Password,
  ProfileDetails,
  UpdateProfileDetails,
  VerifyEmail,
  CommonImageUpload
}