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
