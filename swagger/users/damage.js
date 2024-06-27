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
 *       required:
 *         - Schadenart
 *         - Schadenstatus
 *         - FahrzeugTenantItemId
 *         - Schadengruppe
 *         - Schadenursache
 *         - Kennzeichen 
 *         - Schadenschilderung
 *         - Schadendatum
 *         - Schadenmeldedatum  
 *         - Strasse
 *         - Plz
 *         - Ort  
 *         - WerkstattInfo            
 *         - Land            
 *       properties:
 *         Schadenart:
 *           type: string
 *           example: Person
 *           description: Type Of Damage
 *         Schadengruppe:
 *           type: string
 *           example: "Glass Break RockFall" 
 *           description: Damage Group
 *         Schadenursache:
 *           type: string
 *           example: RockFall in field of vision
 *           description: Cause Of Damage
 *         Schadenstatus:
 *           type: string
 *           example: "Recorded"
 *           description: Damage Status
 *         FahrzeugTenantItemId:
 *           type: number
 *           example: 1
 *           description: Vehicle Id
 *         Kennzeichen:
 *           type: string
 *           example: TN15U7396
 *           description: Vehicle Number
 *         Schadenschilderung:
 *           type: string
 *           example: "Damage Description"
 *           description: Description of damage
 *         Schadendatum:
 *           type: date
 *           example: "2024-01-03 13:12:01"
 *           description: Date/time of Damage
 *         Schadenmeldedatum:
 *           type: date
 *           example: "2024-01-04 13:16:01"
 *           description: Date/time of Claim of Notification
 *         Strasse:
 *           type: string
 *           example: Address
 *           description: Street & House No
 *         Plz:
 *           type: string
 *           example: 600015
 *           description: Pincode
 *         Ort:
 *           type: string
 *           example: Chennai
 *           description: Location
 *         WerkstattInfo:
 *           type: String
 *           example: Information
 *           description: Further Information
 *         Land:
 *           type: string
 *           example: India
 *           description: Country
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
 *         application/json:
 *           schema:
 *             $ref: '#/components/schemas/DamageRequestBody'
 *     responses:
 *       200:
 *         description: Success
 */
