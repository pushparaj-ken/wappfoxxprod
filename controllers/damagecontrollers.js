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
        userId: users.BenutzerId,
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
        police: values.police,
        parts: values.parts,
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
        if (values.parts === 'Yes') {
          const Parts = {
            damageId: Result.id,
            tire_front_left: parseInt(values.tire_front_left),
            headlight_front_left: parseInt(values.headlight_front_left),
            rim_front_left: parseInt(values.rim_front_left),
            bumper_front_left: parseInt(values.bumper_front_left),
            headlight_front_right: parseInt(values.headlight_front_right),
            rim_front_right: parseInt(values.rim_front_right),
            tire_front_right: parseInt(values.tire_front_right),
            fender_left: parseInt(values.fender_left),
            side_mirror_left: parseInt(values.side_mirror_left),
            door_front_left: parseInt(values.door_front_left),
            sill_left: parseInt(values.sill_left),
            door_rear_left: parseInt(values.door_rear_left),
            side_window_rear_left: parseInt(values.side_window_rear_left),
            sidepanel_rear_left: parseInt(values.sidepanel_rear_left),
            side_window_front_left: parseInt(values.side_window_front_left),
            engine_hood: parseInt(values.engine_hood),
            windshield: parseInt(values.windshield),
            roof: parseInt(values.roof),
            window_rear: parseInt(values.window_rear),
            tailgate: parseInt(values.tailgate),
            side_window_front_right: parseInt(values.side_window_front_right),
            fender_right: parseInt(values.fender_right),
            side_mirror_right: parseInt(values.side_mirror_right),
            door_front_right: parseInt(values.door_front_right),
            sill_right: parseInt(values.sill_right),
            door_rear_right: parseInt(values.door_rear_right),
            side_window_rear_right: parseInt(values.side_window_rear_right),
            side_panel_rear_right: parseInt(values.side_panel_rear_right),
            tire_rear_left: parseInt(values.tire_rear_left),
            headlight_rear_left: parseInt(values.headlight_rear_left),
            rim_rear_left: parseInt(values.rim_rear_left),
            bumper_rear_left: parseInt(values.bumper_rear_left),
            headlight_rear_right: parseInt(values.headlight_rear_right),
            rim_rear_right: parseInt(values.rim_rear_right),
            tire_rear_right: parseInt(values.tire_rear_right),
          }
          await prisma.damageVehicleParts.create({ data: Parts });
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
      where.damageNo = values.damageNo
    }
    where.userId = users.BenutzerId
    query = { where, include: { parkinglocation: true, documents: true, policedetails: true, partydetails: true } }
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
