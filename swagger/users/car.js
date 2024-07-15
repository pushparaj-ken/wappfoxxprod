/**
 * @swagger
 * tags:
 *   name: Cars
 *   description: Cars management
 */

/**
 * @swagger
 * components:
 *   schemas:
 *     CarsRequestBody:
 *       type: object
 *       required:
 *         - image
 *         - model
 *         - carNumber
 *         - status             
 *       properties:
 *         image:
 *           type: string
 *           example: smaple Image
 *         model:
 *           type: string
 *           example: BMW 120i
 *         carNumber:
 *           type: string
 *           example: DN C 654
 *         status:
 *           type: string
 *           example: aktiv
 *     CarsKmBody:
 *       type: object
 *       required:
 *         - carid
 *         - carno          
 *       properties:
 *         carid:
 *           type: string
 *           example: 2321adada
 *         carno:
 *           type: string
 *           example: DC25W
 *     CarsResponse:
 *       type: object
 *       properties:
 *         message:
 *           type: string
 *           example: Data Saved Success
 */

/**
 * @swagger
 * /api/cars/list:
 *   get:
 *     summary: Cars List
 *     tags: [Cars]
 *     security:
 *       - bearerAuth: []
 *     responses:
 *       200:
 *         description: Success
 */

/**
 * @swagger
 * /api/cars/carkmstand:
 *   post:
 *     summary: Cars KM Stand
 *     tags: [Cars]
 *     security:
 *       - bearerAuth: []
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             $ref: '#/components/schemas/CarsKmBody'
 *     responses:
 *       200:
 *         description: Success
 */
