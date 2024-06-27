// middleware/passport.js
const passport = require('passport');
const { Strategy: JwtStrategy, ExtractJwt } = require('passport-jwt');
const prisma = require('../db/prisma-client/prisma.service');

const jwtOptions = {
  jwtFromRequest: ExtractJwt.fromAuthHeaderAsBearerToken(),
  secretOrKey: process.env.JWT_SECRET
};

passport.use(new JwtStrategy(jwtOptions, async (payload, done) => {
  try {
    //const user = await Bankverbindungen.findOne({ BankverbindungId: payload.id });
    let user = ''

    if (payload.sub === "Users") {
      user = await prisma.benutzers.findUnique({ where: { BenutzerId: payload.id } });
      userKunden = await prisma.benutzer.findUnique({ where: { UserId: user.UserId } });
      user.KundeTenantItemId = userKunden.KundeTenantItemId
    } else {
      user = await prisma.administratorin.findUnique({ where: { Id: payload.id } });
    }
    //console.log(user)
    if (user) {
      return done(null, user);
    } else {
      return done(null, false, { message: 'Unauthorized' });
    }
  } catch (error) {
    return done(error, false);
  }
}));

module.exports = passport;
