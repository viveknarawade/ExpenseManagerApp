const jwt = require("jsonwebtoken");
const bcrypt = require("bcrypt");
const mongoose = require("mongoose");

const userSchema = mongoose.Schema(
  {
    userName: {
      type: String,
      required: true,
      trim: true,
      minlength: 2
    },
    email: {
      type: String,
      required: true,
      unique: true,
      lowercase: true,
      trim: true
    },
    password: {
      type: String,
      required: true,
      minlength: 6  // password rules
    },
    avatar: {
      type: String,
      default: ""  //  default value
    },
    refreshToken: {
      type: String,
      default: null
    }
  },
  { timestamps: true }
);

module.exports = mongoose.model("User", userSchema);

// middle ware
userSchema.pre("save", async function (next) {
  if (this.isModified("password")) {
    this.password = await bcrypt.hash(this.password, 10);
    next();
  } else {
    return next();
  }
});

// method to check password
userSchema.methods.isPasswordCorrect = async function (password) {
  return await bcrypt.compare(password, this.password);
};


// method to gen access token
userSchema.methods.generateAccessToken = function () {
 return  jwt.sign(
    {
      _id: this._id,
      email: this.email,
      userName: this.userName,
    },
    process.env.ACCESS_TOKEN_SECRET,
    {
      expiresIn: process.env.ACCESS_TOKEN_EXPIRY,
    }
  );
};


// method to gen refresh token
userSchema.methods.generateRefreshToken = function () {
  return  jwt.sign(
    {
      _id: this._id,
    },
    process.env.REFRESH_TOKEN_SECRET,
    {
      expiresIn: process.env.REFRESH_TOKEN_EXPIRY ,
    }
  );
};

module.exports = mongoose.model("User", userSchema);
