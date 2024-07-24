/**
 * @swagger
 * tags:
 *   name: Damage
 *   description: Damage management
 */


/**
 * @swagger
 * components:
 *   schemas:
 *     DamageRequestBody:
 *       type: object  
 *       properties:
 *         damageType:
 *           type: string
 *           example: Person
 *           description: Type Of Damage
 *         damageGroup:
 *           type: string
 *           example: "Glass Break RockFall" 
 *           description: Damage Group
 *         couseofDamage:
 *           type: string
 *           example: RockFall in field of vision
 *           description: Cause Of Damage
 *         damageStatus:
 *           type: string
 *           example: "Recorded"
 *           description: Damage Status
 *         vehicleId:
 *           type: number
 *           example: 2
 *           description: Vehicle Id
 *         vehicleNo:
 *           type: string
 *           example: TN15U7396
 *           description: Vehicle Number
 *         damageDescription:
 *           type: string
 *           description: Description of damage
 *         damageDate:
 *           type: date
 *           example: "2024-01-03 13:12:01"
 *           description: Date/time of Damage
 *         damageReportDate:
 *           type: date
 *           example: "2024-01-04 13:16:01"
 *           description: Date/time of Claim of Notification
 *         street:
 *           type: string
 *           description: Street & House No
 *         pincode:
 *           type: string
 *           description: Pincode
 *         city:
 *           type: string
 *           description: Location
 *         workshopInfo:
 *           type: String
 *           description: Further Information
 *         country:
 *           type: string
 *           description: Country
 *         Mileage:
 *           type: string
 *           description: Mileage
 *         tripType:
 *           type: string
 *           description: Business trip/Private trip
 *         isAlcohol:
 *           type: string
 *           description: Yes/No
 *         party:
 *           type: string
 *           description: Yes/No
 *         police:
 *           type: string
 *           description: Yes/No
 *         parts:
 *           type: string
 *           description: Yes/No
 *         partyName:
 *           type: string
 *           description: party Name
 *         partyAddress:
 *           type: string
 *           description: party Address
 *         partyCompany:
 *           type: string
 *           description: party Company
 *         partyEmail:
 *           type: string
 *           description: party Email
 *         partyTelephone:
 *           type: string
 *           description: party Telephone
 *         partyInsurance:
 *           type: string
 *           description: party Insurance
 *         partyInsurancenumber:
 *           type: string
 *           description: party Insurancenumber
 *         PoliceInvestigationfileN:
 *           type: string
 *           description: Police InvestigationfileN
 *         PoliceDiarynumber:
 *           type: string
 *           description: Police Diarynumber
 *         PoliceDepartment:
 *           type: string
 *           description: Police Department
 *         PoliceStreet:
 *           type: string
 *           description: Police Street
 *         Policepincode:
 *           type: string
 *           description: Police pincode
 *         Policecity:
 *           type: string
 *           description: Police city
 *         parkingstreet:
 *           type: string
 *           description: parking street
 *         parkingpincode:
 *           type: string
 *           description: parking pincode
 *         parkingcity:
 *           type: string
 *           description: parking city
 *         parkingworkshopInfo:
 *           type: string
 *           description: parking workshopInfo
 *         parkingcountry:
 *           type: string
 *           description: parking country
 *         documentsname:
 *           type: string
 *           description: documents name
 *         categoryname:
 *           type: string
 *           example: India
 *           description: category name
 *         partyname:
 *           type: string
 *           example: India
 *           description: party name
 *         categoryimage:
 *           type: string
 *           format: binary
 *         partyinvoleimage:
 *           type: string
 *           format: binary
 *         image:
 *           type: string
 *           format: binary
 *         tire_front_left:
 *           type: string
 *           example: 0
 *         headlight_front_left:
 *           type: string
 *           example: 0
 *         rim_front_left:
 *           type: string
 *           example: 0
 *         bumper_front_left:
 *           type: string
 *           example: 0
 *         headlight_front_right:
 *           type: string
 *           example: 0
 *         rim_front_right:
 *           type: string
 *           example: 0
 *         tire_front_right:
 *           type: string
 *           example: 0
 *         fender_left:
 *           type: string
 *           example: 0
 *         side_mirror_left:
 *           type: string
 *           example: 0
 *         door_front_left:
 *           type: string
 *           example: 0
 *         sill_left:
 *           type: string
 *           example: 0
 *         door_rear_left:
 *           type: string
 *           example: 0
 *         side_window_rear_left:
 *           type: string
 *           example: 0
 *         sidepanel_rear_left:
 *           type: string
 *           example: 0
 *         side_window_front_left:
 *           type: string
 *           example: 0
 *         engine_hood:
 *           type: string
 *           example: 0
 *         windshield:
 *           type: string
 *           example: 0
 *         roof:
 *           type: string
 *           example: 0
 *         window_rear:
 *           type: string
 *           example: 0
 *         tailgate:
 *           type: string
 *           example: 0
 *         side_window_front_right:
 *           type: string
 *           example: 0
 *         fender_right:
 *           type: string
 *           example: 0
 *         side_mirror_right:
 *           type: string
 *           example: 0
 *         door_front_right:
 *           type: string
 *           example: 0
 *         sill_right:
 *           type: string
 *           example: 0
 *         door_rear_right:
 *           type: string
 *           example: 0
 *         side_window_rear_right:
 *           type: string
 *           example: 0
 *         side_panel_rear_right:
 *           type: string
 *           example: 0
 *         tire_rear_left:
 *           type: string
 *           example: 0
 *         headlight_rear_left:
 *           type: string
 *           example: 0
 *         rim_rear_left:
 *           type: string
 *           example: 0
 *         bumper_rear_left:
 *           type: string
 *           example: 0
 *         headlight_rear_right:
 *           type: string
 *           example: 0
 *         rim_rear_right:
 *           type: string
 *           example: 0
 *         tire_rear_right:
 *           type: string
 *           example: 0
 *     DamageResponse:
 *       type: object
 *       properties:
 *         message:
 *           type: string
 *           example: Data Saved Success
 */


/**
 * @swagger
 * /api/damage/add:
 *   post:
 *     summary: Add Damage
 *     tags: [Damage]
 *     requestBody:
 *       required: true
 *       content:
 *         multipart/form-data:
 *           schema:
 *             $ref: '#/components/schemas/DamageRequestBody'
 *     responses:
 *       200:
 *         description: Success
 */

/**
 * @swagger
 * /api/damage/list:
 *   get:
 *     summary: Damage List
 *     tags: [Damage]
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: query
 *         name: damageNo
 *         schema:
 *           type: string
 *         required: false
 *         description: Filter by damageNo 
 *     responses:
 *       200:
 *         description: Success
 */