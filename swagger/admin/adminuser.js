/**
 * @swagger
 * tags:
 *   name: Admin
 *   description: Admin Management
 */

/**
 * @swagger
 * components:
 *   schemas:
 *     AdminRequestBody:
 *       type: object
 *       required:
 *         - EMailAdresse
 *         - Passwort  
 *         - VorundNachname
 *         - Telefonnummer
 *       properties:
 *         Vorname:
 *           type: string
 *           example: smaple Name
 *         Nachname:
 *           type: string
 *           example: smaple Name
 *         Passwort:
 *           type: string
 *           example: 123456
 *         EMailAdresse:
 *           type: string
 *           example: admin@gmail.com
 *         Telefonnummer:
 *            type: number
 *            example: 9876543210
 *     AdminloginBody:
 *       type: object
 *       required:
 *         - EMailAdresse
 *         - Passwort
 *       properties:
 *         EMailAdresse:
 *           type: string
 *           example: admin@gmail.com
 *         Passwort:
 *           type: string
 *           example: 123456
 *     AdminemailsendBody:
 *       type: object
 *       required:
 *         - EMailAdresse
 *       properties:
 *         EMailAdresse:
 *           type: string
 *           example: admin@gmail.com
 *     AdminemailverifyBody:
 *       type: object
 *       required:
 *         - EMailAdresse
 *         - code
 *       properties:
 *         EMailAdresse:
 *           type: string
 *           example: admin@gmail.com 
 *         code:
 *           type: number
 *           example: 123456
 *     AdminResponse:
 *       type: object
 *       properties:
 *         message:
 *           type: string
 *           example: Data Saved Success
 */

/**
 * @swagger
 * /api/admin/login:
 *   post:
 *     summary: Login
 *     tags: [Admin]
 *     requestBody:
 *      required: true
 *      content:
 *         application/json:
  *           schema:
  *             $ref: '#/components/schemas/AdminloginBody'
 *     responses:
 *       200:
 *         description: Data Saved Success
 */

/**
 * @swagger
 * /api/admin/register:
 *   post:
 *     summary: Register
 *     tags: [Admin]
 *     requestBody:
 *      required: true
 *      content:
 *         application/json:
  *           schema:
  *             $ref: '#/components/schemas/AdminRequestBody'
 *     responses:
 *       200:
 *         description: Data Saved Success
 */

/**
 * @swagger
 * /api/admin/dashboard:
 *   get:
 *     summary: Dashboard 
 *     tags: [Admin]
 *     responses:
 *       200:
 *         description: Data Saved Success
 */

/**
 * @swagger
 * /api/admin/sendemail:
 *   post:
 *     summary: Send Email
 *     tags: [Admin]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             $ref: '#/components/schemas/AdminemailsendBody'
 *     responses:
 *       200:
 *         description: Email Send successful
 */

/**
 * @swagger
 * /api/admin/verifyemail:
 *   put:
 *     summary: Verify Email
 *     tags: [Admin]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             $ref: '#/components/schemas/AdminemailverifyBody'
 *     responses:
 *       200:
 *         description: Email verification successful
 */


/**
 * @swagger
 * /api/admin/damagelist:
 *   get:
 *     summary: Damage List
 *     tags: [Admin]
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: query
 *         name: damageNo
 *         schema:
 *           type: string
 *         required: false
 *         description: Filter by damageNo 
 *       - in: query
 *         name: userId
 *         schema:
 *           type: string
 *         required: false
 *         description: Filter by user 
 *     responses:
 *       200:
 *         description: Success
 */