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



const DamageDashboard = catchAsync(async (req, res, next) => {
  try {
    const values = req.body
    const params = req.params;
    const cars = await prisma.fahrzeuge.findUnique({
      where: { TenantItemId: parseInt(params.id) }, select: {
        TenantItemId: true,
        Modell: true,
        Kennzeichen: true,
        Fahrzeugstatus: true,
      },
    })
    if (cars) {
      const carsdetails = {
        id: cars.TenantItemId,
        image: "https://paizatto.s3.ap-south-1.amazonaws.com/grafik8f29dc91-09d7-4a76-baab-6e493a7f48b8.png",
        Modell: cars.Modell,
        Kennzeichen: cars.Kennzeichen,
        Fahrzeugstatus: cars.Fahrzeugstatus,
      };
      const reportsDetails = await prisma.schaden.findMany({ where: { FahrzeugTenantItemId: cars.TenantItemId } })

      carsdetails.Reports = []
      for (const each of reportsDetails) {
        let Data = {}
        Data.id = each.Id
        Data.damageType = each.Schadengruppe + ' ' + each.Schadenart + ' ' + Formatter.toDate(each.Schadendatum)
        Data.damageStatus = each.Schadenstatus
        Data.reportId = each.SchadenNummer
        carsdetails.Reports.push(Data)
      }
      res.send({
        success: true,
        code: 200,
        status: "Data Retrieved Success",
        Data: carsdetails,
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


const DamageStatus = catchAsync(async (req, res, next) => {
  try {
    const values = req.body
    const params = req.params;

    const reportsDetails = await prisma.schaden.findUnique({ where: { Id: parseInt(params.id) } })
    const cars = await prisma.fahrzeuge.findUnique({
      where: { TenantItemId: parseInt(reportsDetails.FahrzeugTenantItemId) }, select: {
        TenantItemId: true,
        Modell: true,
        Kennzeichen: true,
        Fahrzeugstatus: true,
      },
    })
    const carsdetails = {
      id: cars.TenantItemId,
      image: "https://paizatto.s3.ap-south-1.amazonaws.com/grafik8f29dc91-09d7-4a76-baab-6e493a7f48b8.png",
      Modell: cars.Modell,
      Kennzeichen: cars.Kennzeichen,
      Fahrzeugstatus: cars.Fahrzeugstatus,
    };
    carsdetails.Reports = {
      id: reportsDetails.Id,
      damageType: reportsDetails.Schadengruppe + ' ' + reportsDetails.Schadenart + ' ' + Formatter.toDate(reportsDetails.Schadendatum),
      damageStatus: reportsDetails.Schadenstatus,
      reportId: reportsDetails.SchadenNummer,
    }
    const DamageStatus = await prisma.logbuch.findMany({ where: { SchadenId: parseInt(params.id) }, select: { LogText: true, LogTime: true } })
    if (DamageStatus) {
      carsdetails.Status = []
      for (const each of DamageStatus) {
        let Data = {}
        Data.RepairStatus = each.LogText
        Data.Date = Formatter.toDate(each.LogTime) + " " + Formatter.toTime(each.LogTime)
        carsdetails.Status.push(Data)
      }
      res.send({
        success: true,
        code: 200,
        status: "Data Retrieved Success",
        Data: carsdetails,
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

const carsStatus = {
  "Reports": [
    {
      "id": "62f0aa5eda389d0d5b00815b",
      "damageType": "Glasschaden vom 14.12.2023",
      "damageStatus": "in Werkstatt",
      "reportId": "WAZUU858GF76"
    },
    {
      "id": "62f12181a85b82140325e157",
      "damageType": "Panne/technischer Defekt vom 22.09.2023",
      "damageStatus": "abgeschlossen",
      "reportId": "WAZUU858GF76"
    }
  ]
}


function findReportIdByDamageType(damageType) {
  const report = carsStatus.Reports.find(report => report.id === damageType);
  let carsStatus1 = {}
  if (report) {
    carsStatus1 = JSON.parse(localStorage.getItem('cars'));
    carsStatus1.Reports = report
  } else {
    carsStatus1.Reports = {}
  }
  return carsStatus1;
}

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
  DamageDashboard,
  DamageStatus,
  CarkmStand,
}