const catchAsync = require('../utils/catchAsync');
const LocalStorage = require('node-localstorage').LocalStorage;
const localStorage = new LocalStorage('./scratch');
const prisma = require('../db/prisma-client/prisma.service');
const Formatter = require('../services/formatter')

const CarsList = catchAsync(async (req, res, next) => {
  try {
    const users = req.user;
    if (users.EMailAdresse != '' && users.EMailAdresse != null && users.EMailAdresse != undefined) {
      const carsDetails = await prisma.$queryRaw`select c.* from Adresse as a, Fahrer as b,Fahrzeuge as c where a.Emailadresse = ${users.EMailAdresse} and b.FahrerId = a.FahrerId and c.TenantItemId = b.FahrzeugTenantItemId`;
      if (carsDetails.length > 0) {
        const Records = [];
        for (const each of carsDetails) {
          let Data = {}
          Data.id = each.TenantItemId
          Data.image = "https://paizatto.s3.ap-south-1.amazonaws.com/grafik8f29dc91-09d7-4a76-baab-6e493a7f48b8.png"
          Data.model = each.Modell
          Data.carNumber = each.Kennzeichen
          Data.status = each.Fahrzeugstatus
          const reportsDetails = await prisma.schaden.findMany({ where: { FahrzeugTenantItemId: each.TenantItemId } })
          Data.Reports = []
          for (const each of reportsDetails) {
            let Damagelist = {}
            Damagelist.id = each.Id
            Damagelist.damageType = each.Schadengruppe + ' ' + each.Schadenart + ' ' + Formatter.toDate(each.Schadendatum)
            Damagelist.damageStatus = each.Schadenstatus
            Damagelist.reportId = each.SchadenNummer
            const DamageStatus = await prisma.logbuch.findMany({
              where: { SchadenId: each.Id },
              select: { LogText: true, LogTime: true }
            })
            Damagelist.Status = []
            for (const damage of DamageStatus) {
              let Log = {}
              Log.RepairStatus = damage.LogText
              Log.Date = Formatter.toDate(damage.LogTime) + " " + Formatter.toTime(damage.LogTime)
              Damagelist.Status.push(Log)
            }
            Data.Reports.push(Damagelist)
          }
          Records.push(Data)
        }
        res.send({
          success: true,
          code: 200,
          status: "Data Retrieved Success",
          Data: Records,
          timestamp: new Date(),
        });
      } else {
        const errcode = new Error("No Data exists.");
        errcode.statusCode = 201;
        return next(errcode);
      }
    } else {
      const errcode = new Error("Users exists.");
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

const CarkmStand = catchAsync(async (req, res, next) => {
  try {
    const values = req.body
    if (values.carid && values.carid.trim() !== '' && values.carno && values.carno.trim() !== '') {
      res.send({
        success: true,
        code: 200,
        status: "Data Successfully Added",
        timestamp: new Date(),
      });
    } else {
      const errcode = new Error("All Field are Monitory");
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
  CarsList,
  CarkmStand
}