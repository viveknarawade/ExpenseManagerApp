const asyncHandler = require("../utils/asyncHandler.js");
const ApiError = require("../utils/ApiError.js");
const ApiResponse = require("../utils/ApiResponse.js");
const User = require("../models/user.model.js");
const uploadOnCloudinary = require("../utils/cloudinary.js");

const registerUser = asyncHandler(async (req, res) => {
  // get user details from frontend
  // vaildation - not empty
  // check if user already exits : email
  // check avatar img
  // upload them on cloudinary
  // create user object - create entry in db
  // remove password and refresh token from response
  // check for user creation
  // return response

  const { userName, email, password } = req.body;

  // 1. Validate required fields
  if ([userName, email, password].some((field) => !field?.trim())) {
    throw new ApiError(400, "All fields are required");
  }

  // 2. Check if user already exists
  const existingUser = await User.findOne({ email });

  if (existingUser) {
    throw new ApiError(409, "User with this email already exists");
  }

  // 3. Get avatar local path
  const avatarLocalPath = req.files?.avatar[0]?.path;
  console.log(avatarLocalPath);
  if (!avatarLocalPath) {
    throw new ApiError(400, "Avatar image is required");
  }

  // 4. Upload image to Cloudinary
  const avatar = await uploadOnCloudinary(avatarLocalPath);

  if (!avatar) {
    throw new ApiError(500, "Cloudinary upload failed");
  }

  // 5. Create user in DB
  const user = await User.create({
    userName,
    email,
    password,
    avatar: avatar.url,
  });

  // 6. Remove sensitive fields before sending
  const createdUser = await User.findById(user._id).select(
    "-password -refreshToken"
  );
  if (!createdUser) {
    throw new ApiError(500, "Something went wrong while registering the user");
  }

  // 7. Send response
  return res
    .status(201)
    .json(new ApiResponse(200, createdUser, "User registered successfully"));
});

module.exports = registerUser;
