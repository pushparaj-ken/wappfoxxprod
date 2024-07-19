/**
 * @swagger
 * tags:
 *   name: Users
 *   description: User management
 */

/**
 * @swagger
 * components:
 *   schemas:
 *     UsersRequestBody:
 *       type: object
 *       required:
 *         - VorundNachname
 *         - zugehorigesUnternehmen
 *         - EMailAdresse  
 *         - kundencode
 *       properties:
 *         VorundNachname:
 *           type: string
 *           example: smaple Name
 *         zugehorigesUnternehmen:
 *           type: string
 *           example: company Name
 *         EMailAdresse:
 *           type: string
 *           example: admin@gmail.com
 *         kundencode:
 *           type: string
 *           example: 98765432
 *     UsersloginBody:
 *       type: object
 *       required:
 *         - EMailAdresse
 *         - Passwort
 *         - kundencode
 *       properties:
 *         EMailAdresse:
 *           type: string
 *           example: admin@gmail.com
 *         Passwort:
 *           type: string
 *           example: 123456
 *         kundencode:
 *           type: number
 *           example: 98765432
 *     UsersPasswordBody:
 *       type: object
 *       required:
 *         - Passwort
 *         - cPasswort
 *       properties:
 *         Passwort:
 *           type: string
 *           example: 123456
 *         cPasswort:
 *           type: string
 *           example: 123456
 *     UsersverifyBody:
 *       type: object
 *       required:
 *         - vcode
 *       properties:
 *         vcode:
 *           type: string
 *           example: 123456 
 *     UpdateUsersRequestBody:
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
 *     UsersemailsendBody:
 *       type: object
 *       required:
 *         - EMailAdresse
 *       properties:
 *         EMailAdresse:
 *           type: string
 *           example: admin@gmail.com
 *     UsersemailverifyBody:
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
 *     UsersResponse:
 *       type: object
 *       properties:
 *         message:
 *           type: string
 *           example: Data Saved Success
 */

/* Public Routes */
/**
 * @swagger
 * /api/users/login:
 *   post:
 *     summary: Login
 *     tags: [Users]
 *     requestBody:
 *      required: true
 *      content:
 *         application/json:
  *           schema:
  *             $ref: '#/components/schemas/UsersloginBody'
 *     responses:
 *       200:
 *         description: Data Saved Success
 */
/**
 * @swagger
 * /api/users/register:
 *   post:
 *     summary: Register
 *     tags: [Users]
 *     requestBody:
 *      required: true
 *      content:
 *         application/json:
  *           schema:
  *             $ref: '#/components/schemas/UsersRequestBody'
 *     responses:
 *       200:
 *         description: Data Saved Success
 */
/**
 * @swagger
 * /api/users/password:
 *   put:
 *     summary: Password Update
 *     tags: [Users]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             $ref: '#/components/schemas/UsersPasswordBody'
 *     responses:
 *       200:
 *         description: Password updated successfully
 */
/**
 * @swagger
 * /api/users/verify:
 *   post:
 *     summary: Verify
 *     tags: [Users]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             $ref: '#/components/schemas/UsersverifyBody'
 *     responses:
 *       200:
 *         description: Email verification successful
 */

/**
 * @swagger
 * /api/users/updateprofile:
 *   put:
 *     summary: update profile
 *     tags: [Users]
 *     requestBody:
 *      required: true
 *      content:
 *         application/json:
  *           schema:
  *             $ref: '#/components/schemas/UpdateUsersRequestBody'
 *     responses:
 *       200:
 *         description: Data Saved Success
 */

/**
 * @swagger
 * /api/users/profile:
 *   get:
 *     summary: get profile
 *     tags: [Users]
 *     responses:
 *       200:
 *         description: Data Saved Success
 */
/**
 * @swagger
 * /api/users/sendemail:
 *   post:
 *     summary: Send Email
 *     tags: [Users]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             $ref: '#/components/schemas/UsersemailsendBody'
 *     responses:
 *       200:
 *         description: Email Send successful
 */

/**
 * @swagger
 * /api/users/verifyemail:
 *   put:
 *     summary: Verify Email
 *     tags: [Users]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             $ref: '#/components/schemas/UsersemailverifyBody'
 *     responses:
 *       200:
 *         description: Email verification successful
 */

/**
 * @swagger
 * /api/users/imageupload:
 *   post:
 *     summary: Common Image upload
 *     tags: [Users]
 *     requestBody:
 *       required: true
 *       content:
 *         multipart/form-data:
 *           schema:
 *             type: object
 *             properties:
 *               image:
 *                   type: string
 *                   format: binary
 *     responses:
 *       200:
 *         description: Success
 */