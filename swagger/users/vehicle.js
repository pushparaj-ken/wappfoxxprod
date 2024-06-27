/**
 * @swagger
 * tags:
 *   name: Vehicle
 *   description: Vehicle management
 */


/**
 * @swagger
 * /api/vehicle/list:
 *   get:
 *     summary: Vehicle List
 *     tags: [Vehicle]
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: query
 *         name: TenantItemId
 *         schema:
 *           type: number
 *         required: false
 *         description: Filter by TenantItemId Vehicle
 *     responses:
 *       200:
 *         description: Success
 */
