const catchAsync = require('../utils/catchAsync');
const prisma = require('../db/prisma-client/prisma.service');
const Formatter = require('../services/formatter')

const AddDamage = catchAsync(async (req, res, next) => {
  try {
    const users = req.user;
    const values = req.body;
    values.Schadensort = ''
    values.Fahrzeugstatus = ''
    values.LaufleistungInKm = 0
    values.Alkohol = false
    values.Abholadresse = ''
    values.Besichtigungsort = ''
    values.GutachtenTyp = ''
    values.Gutachterfestlegung = false
    values.GkkBilder = false
    values.NutzungsausfallInTagen = 0
    values.Anlieferungsort = ''
    values.MietwagenTyp = ''
    values.Reparaturkosten = 0.0
    values.Restwert = 0.0
    values.GutschriftVersicherung = 0.0
    values.Eigenanteil = 0.0
    values.SummeGutachten = 0.0
    values.SummeKostenvoranschlag = 0.0
    values.KostenKarosserieInstandhaltung = 0.0
    values.Mietwagenkosten = 0.0
    values.KostenWindschutzscheibeInstandhaltung = 0.0
    values.Gutachterkosten = 0.0
    values.Wiederbeschaffungswert = 0.0
    values.NutzungsausfallProTag = 0.0
    values.NutzungsausfallGesamt = 0.0
    values.Wertminderung = 0.0
    values.SchadenstatusBegruendung = ''
    values.Schadendatum = new Date(values.Schadendatum)
    values.Schadenmeldedatum = new Date(values.Schadenmeldedatum)
    values.KundeTenantItemId = users.KundeTenantItemId
    values.SchadenNummer = Math.floor(10000000 + Math.random() * 90000000).toString()
    if (values.SchadenNummer != '' && values.SchadenNummer != undefined && values.SchadenNummer != null) {
      await prisma.schaden.create({ data: values }).then((Result) => {
        res.send({
          success: true,
          code: 200,
          status: "Data Retrieved Success",
          timestamp: new Date(),
        });
      });
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


module.exports = {
  AddDamage
}
