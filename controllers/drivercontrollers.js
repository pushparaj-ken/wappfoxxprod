const catchAsync = require('../utils/catchAsync');
const prisma = require('../db/prisma-client/prisma.service');

const AddDriver = catchAsync(async (req, res, next) => {
  try {
    const values = req.body
    if (values.VorundNachname && values.zugehorigesUnternehmen && values.EMailAdresse && values.Passwort && values.VorundNachname.trim() !== '' && values.zugehorigesUnternehmen.trim() !== '' && values.EMailAdresse.trim() !== '') {
      const BankverbindungenDetails = await Driver.findOne({ where: { EMailAdresse: values.EMailAdresse } });
      if (BankverbindungenDetails != null) {
        const errcode = new Error("Email Already Exists");
        errcode.statusCode = 201;
        return next(errcode);
      } else {
        const DriverDetails = await Driver.create(values);
        if (DriverDetails) {
          res.send({
            success: true,
            code: 200,
            status: "Driver Register Successfully",
            timestamp: new Date(),
            data: DriverDetails,
          });
        } else {
          const errcode = new Error("No Records Found");
          errcode.statusCode = 201;
          return next(errcode);
        }
      }
    } else {
      const errcode = new Error("All Field are Monitory");
      errcode.statusCode = 201;
      return next(errcode);
    }

  } catch (error) {
    const errcode = new Error(error.message);
    errcode.statusCode = 201;
    return next(errcode);
  }
});


const ListDriver = catchAsync(async (req, res, next) => {
  try {
    let values = req.query
    let query = {}
    if (values.KundeTenantItemId !== '' && values.KundeTenantItemId !== null && values.KundeTenantItemId !== undefined) {
      query.KundeTenantItemId = values.KundeTenantItemId
    }
    let take = 20
    if (values.limit != '' && values.limit != undefined && values.limit != null) {
      take = parseInt(values.limit)
    }
    let skip = 0
    let page1 = values.page - 1;
    if (values.hasOwnProperty("page")) {
      if (page1 > 0) {
        skip = skip + (take * (parseInt(page1)));
      }
    }
    const DriverDetails = await prisma.benutzers.findMany({
      where: query,
      skip,
      take,
    });
    if (DriverDetails.length > 0) {
      // for (const each of DriverDetails) {
      //   const Address = await prisma.adresse.findFirst({ where: { FahrerId: each.FahrerId } })
      //   each.userAddress = Address
      // }
      // console.log("🚀 ~ ListDriver ~ DriverDetails:", DriverDetails)
      res.send({
        success: true,
        code: 200,
        status: "Data Retrieved successfully",
        timestamp: new Date(),
        data: DriverDetails
      });
    } else {
      const errcode = new Error("No Records Found");
      errcode.statusCode = 201;
      return next(errcode);
    }
  } catch (error) {
    const errcode = new Error(error.stack);
    errcode.statusCode = 201;
    return next(errcode);
  }
});

const UpdateDriverDetails = catchAsync(async (req, res, next) => {
  try {
    const values = req.body
    const params = req.params;
    if (params.id != '' && params.id != null && params.id != undefined) {
      const existingRecord = await prisma.benutzers.findUnique({ where: { BenutzerId: parseInt(params.id) } });
      if (existingRecord) {
        const data = values
        const where = { BenutzerId: parseInt(params.id) }
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
      const errcode = new Error("Id required to Update Driver.");
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

const DeleteDriverDetails = catchAsync(async (req, res, next) => {
  try {
    const params = req.params;
    if (params.id != '' && params.id != null && params.id != undefined) {
      const existingRecord = await prisma.benutzers.findUnique({ where: { BenutzerId: parseInt(params.id) } });
      if (existingRecord) {
        const query = {
          where: { BenutzerId: existingRecord.BenutzerId } // The condition to find the record(s)
        }
        await prisma.benutzers.delete(query);
        res.send({
          success: true,
          code: 200,
          status: "Data Delete Success",
        });
      } else {
        const errcode = new Error("Record not Found");
        errcode.statusCode = 201;
        return next(errcode);
      }

    } else {
      const errcode = new Error("Id required to Delete Driver.");
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
  AddDriver,
  ListDriver,
  UpdateDriverDetails,
  DeleteDriverDetails,
}