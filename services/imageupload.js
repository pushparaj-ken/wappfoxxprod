const { S3Client, PutObjectCommand } = require("@aws-sdk/client-s3");
const Sharp = require("sharp");
const { ImageExtensions } = require("./extension");
const { v4: uuidv4 } = require('uuid'); // Correct way to import uuid in JavaScript

// Amazon SES configuration
const config = {
  region: process.env.AWS_S3_REGION,
  credentials: {
    accessKeyId: process.env.AWS_S3_ACCESS_KEY_ID,
    secretAccessKey: process.env.AWS_S3_SECRET_ACCESS_KEY
  }
};

const s3Client = new S3Client(config);

async function upload(file, fileName, foldername) {
  try {
    const epochtimeseconds = uuidv4();
    fileName = fileName.replace(".", `${epochtimeseconds}.`);
    const splitFileName = fileName.split(".");
    const extensionOfFile = splitFileName[1];

    let params = {
      Bucket: process.env.AWS_S3_BUCKET_NAME,
      Key: `${fileName}`,
      Body: ''
    };

    if (ImageExtensions.includes(extensionOfFile)) {
      try {
        const buffer = await Sharp(file)
          .webp({ quality: 20 })
          .resize(null, null, { fit: Sharp.fit.inside, withoutEnlargement: true })
          .toBuffer();
        params.Body = buffer;
      } catch (error) {
        throw new Error(`Image processing error: ${error}`);
      }
    } else {
      params.Body = file;
    }

    try {
      await s3Client.send(new PutObjectCommand(params));
      const fileUrl = `https://${process.env.AWS_S3_BUCKET_NAME}.s3.${process.env.AWS_S3_REGION}.amazonaws.com/${params.Key}`;
      return { Location: fileUrl };
    } catch (error) {
      throw new Error(`S3 upload error: ${error}`);
    }
  } catch (error) {
    throw new Error(error.message);
  }
}

async function uploadImages(file, fileName, Username, fieldname) {
  const splitFileName1 = fileName.split(".");
  const extensionOfFile1 = splitFileName1[1];
  const epochtimeseconds = uuidv4();
  fileName = `${Username}_${fieldname}_${epochtimeseconds}.${extensionOfFile1}`;

  let params = {
    Bucket: process.env.AWS_S3_BUCKET_NAME,
    Key: fileName,
    Body: ''
  };

  if (ImageExtensions.includes(extensionOfFile1)) {
    try {
      const buffer = await Sharp(file)
        .webp({ quality: 20 })
        .resize(null, null, { fit: Sharp.fit.inside, withoutEnlargement: true })
        .toBuffer();
      params.Body = buffer;
    } catch (error) {
      throw new Error(`Image processing error: ${error}`);
    }
  } else {
    params.Body = file;
  }

  try {
    await s3Client.send(new PutObjectCommand(params));
    const fileUrl = `https://${process.env.AWS_S3_BUCKET_NAME}.s3.${process.env.AWS_S3_REGION}.amazonaws.com/${params.Key}`;
    return { Location: fileUrl };
  } catch (error) {
    throw new Error(`S3 upload error: ${error}`);
  }
}

async function uploadArray(files, foldername) {
  const uploadPromises = files.map(async (file) => {
    const params = {
      Bucket: process.env.AWS_S3_BUCKET_NAME,
      Key: `${foldername}/${file.originalname}`,
      Body: ''
    };

    try {
      const buffer = await Sharp(file)
        .webp({ quality: 20 })
        .resize(null, null, { fit: Sharp.fit.inside, withoutEnlargement: true })
        .toBuffer();
      params.Body = buffer;
    } catch (error) {
      throw new Error(`Image processing error: ${error}`);
    }

    try {
      await s3Client.send(new PutObjectCommand(params));
    } catch (error) {
      throw new Error(`S3 upload error: ${error}`);
    }
  });

  try {
    await Promise.all(uploadPromises);
    return true;
  } catch (error) {
    throw new Error(`Failed to upload one or more files: ${error}`);
  }
}

module.exports = {
  upload,
  uploadImages,
  uploadArray,
};
