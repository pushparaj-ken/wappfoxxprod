/**
 * @swagger
 * tags:
 *   name: Driver
 *   description: Driver management
 */

/**
 * @swagger
 * components:
 *   schemas:
 *     DriverRequestBody:
 *       type: object
 *       required:
 *         - VorundNachname
 *         - zugehorigesUnternehmen
 *         - EMailAdresse
 *         - KundeTenantItemId  
 *         - Passwort   
 *       properties:
 *         VorundNachname:
 *           type: string
 *           example: First Name
 *         zugehorigesUnternehmen:
 *           type: string
 *           example: Company Name
 *         EMailAdresse:
 *           type: string
 *           example: sample@gmail.com
 *         KundeTenantItemId:
 *           type: number
 *           example: 12
 *           description: customer Id
 *         Passwort:
 *           type: string
 *           example: Abcd@1234$
 *     UpdateDriverRequestBody:
 *       type: object
 *       properties:
 *         VorundNachname:
 *           type: string
 *           example: smaple Name
 *         StraBeundHausnummer:
 *           type: string
 *           example: StraBeundHausnummer
 *         PLZ:
 *           type: number
 *           example: 600015
 *         Ort:
 *           type: string
 *           example: Ort
 *         zugehorigesUnternehmen:
 *           type: string
 *           example: zugehorigesUnternehmen
 *         Kennzeichen:
 *           type: string
 *           example: Kennzeichen
 *         EMailAdresse:
 *           type: string
 *           example: admin@gmail.com
 *         Telefonnummer:
 *           type: string
 *           example: 9876543210
 *         CountryCode:
 *           type: string
 *           example: "+91"
 *     DriverResponse:
 *       type: object
 *       properties:
 *         message:
 *           type: string
 *           example: Data Saved Success
 */

/**
 * @swagger
 * /api/admin/driver/add:
 *   post:
 *     summary: Add Driver
 *     tags: [Driver]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             $ref: '#/components/schemas/DriverRequestBody'
 *     responses:
 *       200:
 *         description: Success
 */
/**
 * @swagger
 * /api/admin/driver/list:
 *   get:
 *     summary: List Driver
 *     tags: [Driver]
 *     parameters:
 *       - in: query
 *         name: KundeTenantItemId
 *         schema:
 *           type: string
 *         required: false
 *         description: Filter By customers 
 *       - in: query
 *         name: limit
 *         schema:
 *           type: number
 *         required: false
 *         description: No of records 
 *       - in: query
 *         name: page
 *         schema:
 *           type: number
 *         required: false
 *         description: page no
 *     responses:
 *       200:
 *         description: Success
 */
/**
 * @swagger
 * /api/admin/driver/update/{id}:
 *   put:
 *     summary: Update Driver
 *     tags: [Driver]
 *     parameters:
 *       - in: path
 *         name: id
 *         schema:
 *           type: string
 *         required: true
 *         description: Driver ID
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             $ref: '#/components/schemas/UpdateDriverRequestBody'
 *     responses:
 *       200:
 *         description: Success
 */
/**
 * @swagger
 * /api/admin/driver/delete/{id}:
 *   delete:
 *     summary: Delete Driver
 *     tags: [Driver]
 *     parameters:
 *       - in: path
 *         name: id
 *         schema:
 *           type: string
 *         required: true
 *         description: Driver ID
 *     responses:
 *       200:
 *         description: Success
 */