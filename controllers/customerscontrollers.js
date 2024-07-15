const catchAsync = require('../utils/catchAsync');
const prisma = require('../db/prisma-client/prisma.service');


const AddCustomers = catchAsync(async (req, res, next) => {
  try {
    const values = req.body
    if (values.Vorname && values.Nachname && values.Firmenbezeichnung && values.Nachname.trim() !== '' && values.Firmenbezeichnung.trim() !== '') {
      values.Kundencode = Math.floor(10000000 + Math.random() * 90000000).toString()
      values.OnlineZugang = false
      values.IstFuhrparkmanagement = false
      values.Dokumentueberwachung = false
      const CustomersDetails = await prisma.kunden.create({ data: values });
      if (CustomersDetails) {
        res.send({
          success: true,
          code: 200,
          status: "Custonmers Register Successfully",
          timestamp: new Date(),
          data: CustomersDetails,
        });
      } else {
        const errcode = new Error("No Records Found");
        errcode.statusCode = 201;
        return next(errcode);
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


const ListCustomers = catchAsync(async (req, res, next) => {
  try {
    let values = req.query
    let query = {}
    if (values.TenantItemId !== '' && values.TenantItemId !== null && values.TenantItemId !== undefined) {
      query.TenantItemId = values.TenantItemId
    }
    if (values.Kundencode != '' && values.Kundencode != null && values.Kundencode != undefined) {
      query.Kundencode = values.Kundencode
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
    const CustomersDetails = await prisma.kunden.findMany({
      where: query,
      orderBy: {
        TenantItemId: 'desc'
      },
      skip,
      take,
      select: {
        TenantItemId: true,
        Kundencode: true,
        Vorname: true,
        Nachname: true,
        Firmenbezeichnung: true
      }
    });
    let Totalcount = await prisma.kunden.count();
    let TotalCustomers = [];
    for (let each of CustomersDetails) {
      const userCount = await prisma.benutzer.count({
        where: {
          KundeTenantItemId: each.TenantItemId,
        },
      });
      const customerData = {
        TenantItemId: each.TenantItemId,
        Kundencode: each.Kundencode,
        Vorname: each.Vorname,
        Nachname: each.Nachname,
        Firmenbezeichnung: each.Firmenbezeichnung,
        TotalUsersCount: userCount
      };
      TotalCustomers.push(customerData)
    }
    if (TotalCustomers.length > 0) {
      res.send({
        success: true,
        code: 200,
        status: "Data Retrieved successfully",
        totalcount: Totalcount,
        timestamp: new Date(),
        data: TotalCustomers
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

const UpdateCustomersDetails = catchAsync(async (req, res, next) => {
  try {
    const values = req.body
    const params = req.params;
    if (params.id != '' && params.id != null && params.id != undefined) {
      const where = { TenantItemId: parseInt(params.id) }
      const existingRecord = await prisma.kunden.findUnique({ where });
      if (existingRecord) {
        const data = values
        await prisma.kunden.update({ data, where });
        res.send({
          success: true,
          code: 200,
          status: "Data Update Success",
        });
      } else {
        const errcode = new Error("Record not Found");
        errcode.statusCode = 201;
        return next(errcode);
      }

    } else {
      const errcode = new Error("Id required to Update Customers.");
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

const DeleteCustomersDetails = catchAsync(async (req, res, next) => {
  try {
    const params = req.params;
    if (params.id != '' && params.id != null && params.id != undefined) {
      const where = { TenantItemId: parseInt(params.id) }
      const existingRecord = await prisma.kunden.findUnique({ where });
      if (existingRecord) {
        await prisma.kunden.delete({ where });
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
      const errcode = new Error("Id required to Delete Customers.");
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
  AddCustomers,
  ListCustomers,
  UpdateCustomersDetails,
  DeleteCustomersDetails,
}