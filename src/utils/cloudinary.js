const cloudinary = require("cloudinary").v2;
const fs = require("fs");
const { models } = require("mongoose");
const { Module } = require("vm");
const { resourceLimits } = require("worker_threads");

// Configure Cloudinary
cloudinary.config({
  cloud_name: process.env.CLOUDINARY_CLOUD_NAME,
  api_key: process.env.CLOUDINARY_API_KEY,
  api_secret: process.env.CLOUDINARY_API_SECRET,
});

// Upload function
const uploadOnCloudinary = async (localFilePath) => {
  try {
    if (!localFilePath) return null;

    const response = await cloudinary.uploader.upload(localFilePath, {
      resource_type: "auto",
    });

    console.log("File is uploaded on Cloudinary:", response.url);
    return response;
  } catch (error) {
    console.error("Cloudinary upload error:", error.message);
    fs.unlinkSync(localFilePath); // Delete file if upload fails
    return null;
  }
};

module.exports = uploadOnCloudinary;
