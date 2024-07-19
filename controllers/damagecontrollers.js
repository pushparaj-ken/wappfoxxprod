const catchAsync = require('../utils/catchAsync');
const prisma = require('../db/prisma-client/prisma.service');
const Formatter = require('../services/formatter')
const imageUpload = require("../services/imageupload");

const AddDamage = catchAsync(async (req, res, next) => {
  try {
    const users = req.user;
    const values = req.body;
    let files = req.files;
    let DamageNumber = Math.floor(10000000 + Math.random() * 90000000).toString();
    if (values) {
      const Damage = {
        damageDate: new Date(values.damageDate),
        damageReportDate: new Date(values.damageReportDate),
        customerId: users.KundeTenantItemId,
        damageNo: DamageNumber,
        damageType: values.damageType,
        damageGroup: values.damageGroup,
        couseofDamage: values.couseofDamage,
        damageStatus: values.damageStatus,
        vehicleId: parseInt(values.vehicleId),
        vehicleNo: values.vehicleNo,
        damageDescription: values.damageDescription,
        street: values.street,
        pincode: parseInt(values.pincode),
        city: values.city,
        workshopInfo: values.workshopInfo,
        country: values.country,
        Mileage: values.Mileage,
        tripType: values.tripType,
        isAlcohol: values.isAlcohol,
        party: values.party,
        police: values.police
      }
      await prisma.damage.create({ data: Damage }).then(async (Result) => {
        if (values.party === 'Yes') {
          const Party = {
            damageId: Result.id,
            Name: values.partyName,
            Address: values.partyAddress,
            Company: values.partyCompany,
            Email: values.partyEmail,
            Telephone: values.partyTelephone,
            Insurance: values.partyInsurance,
            Insurancenumber: values.partyInsurancenumber,
          }
          await prisma.partyDetails.create({ data: Party });
        }
        if (values.police === 'Yes') {
          const Police = {
            damageId: Result.id,
            InvestigationfileNo: values.PoliceInvestigationfileN,
            Diarynumber: values.PoliceDiarynumber,
            Department: values.PoliceDepartment,
            street: values.PoliceStreet,
            pincode: values.Policepincode,
            city: values.Policecity,
          }
          await prisma.policeDetails.create({ data: Police });
        }
        const parkingLocation = {
          damageId: Result.id,
          street: values.parkingstreet,
          pincode: parseInt(values.parkingpincode),
          city: values.parkingcity,
          workshopInfo: values.parkingworkshopInfo,
          country: values.parkingcountry,
        }
        await prisma.parkinglocation.create({ data: parkingLocation });
        let image_new = "";
        if (files.image) {
          const { buffer, originalname } = files.image[0];
          let image = await imageUpload.upload(buffer, originalname);
          image_new = image.Location;
        }
        let categoryimage = "";
        if (files.image) {
          const { buffer, originalname } = files.categoryimage[0];
          let imagecategory = await imageUpload.upload(buffer, originalname);
          categoryimage = imagecategory.Location;
        }
        let partyinvoleimage = "";
        if (files.image) {
          const { buffer, originalname } = files.partyinvoleimage[0];
          let imageparty = await imageUpload.upload(buffer, originalname);
          partyinvoleimage = imageparty.Location;
        }
        const Documents = {
          damageId: Result.id,
          name: values.documentsname,
          categoryname: values.categoryname,
          partyname: values.partyname,
          categoryimage: categoryimage,
          partyinvoleimage: partyinvoleimage,
          image: image_new,
        }
        await prisma.documents.create({ data: Documents });
        res.send({
          success: true,
          code: 200,
          DamageNo: DamageNumber,
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


const DamageDetails = catchAsync(async (req, res, next) => {
  try {
    const users = req.user;
    const values = req.query;
    let where = {}
    let query = {}
    if (values.damageNo != null && values.damageNo != undefined && values.damageNo != '') {
      where = { damageNo: values.damageNo }
      query = { where, include: { parkinglocation: true, documents: true, policedetails: true, partydetails: true } }
    }
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
  AddDamage,
  DamageDetails
}
