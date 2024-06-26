import PrismaService from './prisma.service';

class PrismaClientModule {
  constructor() {
    this.providers = [PrismaService];
    this.exports = [PrismaService];
  }

  getProviders() {
    return this.providers;
  }

  getExports() {
    return this.exports;
  }
}

export default new PrismaClientModule();