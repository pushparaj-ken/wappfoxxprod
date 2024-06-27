const catchAsync = require('../utils/catchAsync');
const prisma = require('../db/prisma-client/prisma.service');
const Formatter = require('../services/formatter')

const VehicleList = catchAsync(async (req, res, next) => {
  try {
    const users = req.user;
    const values = req.query;
    let where = {}
    let query = {}
    if (values.TenantItemId != null && values.TenantItemId != undefined && values.TenantItemId != '') {
      where = { TenantItemId: parseInt(values.TenantItemId) }
      query = { where, include: { Kunden: true } }
    } else {
      let select = { TenantItemId: true, Kennzeichen: true }
      query = { where, select }
    }
    const VechicleDetails = await prisma.fahrzeuge.findMany(query)
    if (VechicleDetails.length > 0) {
      res.send({
        success: true,
        code: 200,
        status: "Data Retrieved Success",
        Data: VechicleDetails,
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
  VehicleList
}
