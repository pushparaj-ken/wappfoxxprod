/**
 * @swagger
 * tags:
 *   name: Customers
 *   description: Customers management
 */

/**
 * @swagger
 * components:
 *   schemas:
 *     CustomersRequestBody:
 *       type: object
 *       required:
 *         - Vorname
 *         - Nachname
 *         - Firmenbezeichnung     
 *       properties:
 *         Vorname:
 *           type: string
 *           example: Test
 *         Nachname:
 *           type: string
 *           example: T
 *         Firmenbezeichnung:
 *           type: string
 *           example: sample
 *     CustomersResponse:
 *       type: object
 *       properties:
 *         message:
 *           type: string
 *           example: Data Saved Success
 */

/**
 * @swagger
 * /api/admin/customers/add:
 *   post:
 *     summary: Add Customers
 *     tags: [Customers]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             $ref: '#/components/schemas/CustomersRequestBody'
 *     responses:
 *       200:
 *         description: Success
 */
/**
 * @swagger
 * /api/admin/customers/list:
 *   get:
 *     summary: List Customers
 *     tags: [Customers]
 *     parameters:
 *       - in: query
 *         name: TenantItemId
 *         schema:
 *           type: string
 *         required: false
 *         description: Filter customers by TenantItemId
 *       - in: query
 *         name: Kundencode
 *         schema:
 *           type: string
 *         required: false
 *         description: Filter customers by Kundencode
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
 * /api/admin/customers/update/{id}:
 *   put:
 *     summary: Update Customers
 *     tags: [Customers]
 *     parameters:
 *       - in: path
 *         name: id
 *         schema:
 *           type: string
 *         required: true
 *         description: Customers ID
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             $ref: '#/components/schemas/CustomersRequestBody'
 *     responses:
 *       200:
 *         description: Success
 */
/**
 * @swagger
 * /api/admin/customers/delete/{id}:
 *   delete:
 *     summary: Delete Customers
 *     tags: [Customers]
 *     parameters:
 *       - in: path
 *         name: id
 *         schema:
 *           type: string
 *         required: true
 *         description: Customers ID
 *     responses:
 *       200:
 *         description: Success
 */