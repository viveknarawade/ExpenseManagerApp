const ApiError = require("../utils/ApiError.js");
const asyncHandler = require("../utils/asyncHandler.js");
const jwt = require("jsonwebtoken");
const User = require("../models/user.model.js");

const verifyJWT = asyncHandler(async (req, res, next) => {
  console.log("🔐 In auth middleware");

  try {
    const token =
      req.cookies?.accessToken ||
      req.header("Authorization")?.replace("Bearer ", "").trim();

    console.log(`BACKEND Access token: [${token}]`);

    if (!token) {
      throw new ApiError(401, "Unauthorized request");
    }

    const decodedToken = jwt.verify(token, process.env.ACCESS_TOKEN_SECRET);

    console.log("BACKEND Decoded JWT:", decodedToken);

    const user = await User.findById(decodedToken?._id).select(
      "-password -refreshToken"
    );

    if (!user) {
      throw new ApiError(401, "Invalid access token");
    }

    req.user = user;
    next();
  } catch (error) {
    console.error("JWT Verification Failed:", error.message);
    throw new ApiError(401, error?.message || "Invalid access token");
  }
});

module.exports = verifyJWT;
