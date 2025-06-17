const registerUser = require("../controllers/user.controller.js");

const upload = require("../middlewares/multer.middleware.js");

const Router = require("express").Router;

const router = Router();

router.route("/register").post(
  upload.fields([
    {
      name: "avatar",
      maxCount: 1,
    },
  ]),
  registerUser
);

module.exports = router;
