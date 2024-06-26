const nodemailer = require('nodemailer');

// Create a transporter using GoDaddy email SMTP settings
const transporter = nodemailer.createTransport({
  host: 'smtpout.secureserver.net', // GoDaddy SMTP server address
  port: 465, // GoDaddy SMTP port (465 for SSL)
  secure: true, // true for 465 port, false for other ports
  auth: {
    user: 'sanjay.d@wappfoxx.de', // Your GoDaddy email address
    pass: 'Citrix@123456' // Your GoDaddy email password
  }
});

// Function to send email using GoDaddy SMTP transporter
async function sendEmail(toEmail, subject, text) {
  return new Promise((resolve, reject) => {
    setImmediate(async () => {
      try {
        // Send mail with defined transport object
        let info = await transporter.sendMail({
          from: 'sanjay.d@wappfoxx.de', // Sender email address (should be your GoDaddy email)
          to: toEmail, // Recipient email address
          subject: subject,
          text: text
        });
        console.log('Email sent: %s', info.messageId);
        resolve({
          code: 200,
          success: true,
          status: info,
          timestamp: new Date()
        })
      } catch (error) {
        reject({
          code: 201,
          success: false,
          status: error.stack,
          timestamp: new Date()
        });
      }
    });
  });
}

module.exports = {
  sendEmail
};
