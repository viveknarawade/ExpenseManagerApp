const {
  registerUser,
  loginUser,
  logoutUser,
} = require("../controllers/user.controller.js");

const upload = require("../middlewares/multer.middleware.js");
const verifyJWT = require("../middlewares/auth.middleware.js");
const Router = require("express").Router;
const router = Router();

// POST /api/v1/users/register
router.route("/register").post(
  upload.fields([
    {
      name: "avatar",
      maxCount: 1,
    },
  ]),
  registerUser
);

// POST /api/v1/users/login
router.route("/login").post(loginUser);

// secured routes

router.route("/logout").post(verifyJWT, logoutUser);

module.exports = router;
