const { PrismaClient } = require('../../node_modules/@prisma/wappfox/client/prisma-schema');

class PrismaService extends PrismaClient {
  constructor() {
    super();
    this.connect();
  }

  async connect() {
    if (!this.$isConnected) {
      await this.$connect();
      console.log('Database connected');
    }
  }

  async disconnect() {
    if (this.$isConnected) {
      await this.$disconnect();
      console.log('Database disconnected');
    }
  }

}

const prisma = new PrismaService();

module.exports = prisma;
