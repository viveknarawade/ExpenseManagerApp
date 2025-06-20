const asyncHandler = require("../utils/asyncHandler.js");
const ApiError = require("../utils/ApiError.js");
const ApiResponse = require("../utils/ApiResponse.js");
const User = require("../models/user.model.js");
const uploadOnCloudinary = require("../utils/cloudinary.js");

const generateAccessAndRefreshTokens = async (userId) => {
  try {
    const user = await User.findById(userId);

    //  Generate tokens
    const accessToken = user.generateAccessToken();
    const refreshToken = user.generateRefreshToken();

    //  Save refreshToken in DB
    user.refreshToken = refreshToken;
    await user.save({ validateBeforeSave: false });

    return { accessToken, refreshToken };
  } catch (error) {
    throw new ApiError(
      500,
      "Something went wrong while generating refresh and access token"
    );
  }
};

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

const loginUser = asyncHandler(async (req, res) => {
  // get user details from frontend
  // username or email
  //find the user
  //password check
  // access and refresh token
  //send cookie
  // res

  const { email, password } = req.body;

  // 1. Validate input
  if (!email || !password) {
    throw new ApiError(400, "Email and password are required");
  }

  // 2. Find user
  const user = await User.findOne({ email });
  if (!user) {
    throw new ApiError(401, "Invalid email or password");
  }

  // 3. Compare password
  const isPasswordCorrect = await user.isPasswordCorrect(password);
  if (!isPasswordCorrect) {
    throw new ApiError(401, "Invalid email or password");
  }

  const { accessToken, refreshToken } = await generateAccessAndRefreshTokens(
    user._id
  );

  const loggedInUser = await User.findById(user._id).select(
    "-password -refreshToken"
  );
  const userObj = loggedInUser.toObject(); // Convert to plain object
  userObj.accessToken = accessToken;
  userObj.refreshToken = refreshToken;

  const options = {
    httpOnly: true,
    secure: true,
  };

  console.log(`BACKEND access token is : ${userObj.accessToken}`);
  console.log(`User logged In Successfully`);


  return res
    .status(200)
    .cookie("accessToken", accessToken, options)
    .cookie("refreshToken", refreshToken, options)
    .json(new ApiResponse(200, userObj, "User logged In Successfully"));
});

const logoutUser = asyncHandler(async (req, res) => {
  console.log("in logout");
  // 1. Clear the refresh token from the user in the database
  const user = await User.findByIdAndUpdate(
    req.user._id,
    {
      $set: {
        refreshToken: undefined, // or you can use: null
      },
    },
    {
      new: true, // return the updated user document (not really used here, but okay to have)
    }
  );

  console.log(`accesstoken : ${user.accessToken}`);

  // 2. Cookie options
  const options = {
    httpOnly: true,
    secure: true,
  };

  // 3. Clear cookies from the browser and send success response
  return res
    .status(200)
    .clearCookie("accessToken", options)
    .clearCookie("refreshToken", options)
    .json(new ApiResponse(200, {}, "User Logged Out"));
});

module.exports = { registerUser, loginUser, logoutUser };
