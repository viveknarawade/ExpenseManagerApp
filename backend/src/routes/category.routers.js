const Router = require("express").Router;
const {addCategories,getCategories,softDeleteCategory} = require("../controllers/categories.controller");
const verifyJWT = require("../middlewares/auth.middleware.js");
const router = Router();
const upload = require("../middlewares/multer.middleware.js");

// ✅ POST  add categories
router.route("").post(
  upload.fields([
    {
      name: "image",
      maxCount: 1,
    },
  ]),
  verifyJWT,
  addCategories
);

// GET   categoried
router.route("").get(verifyJWT, getCategories);


// PATCH delete categoried
router.route("/:id").patch(verifyJWT,softDeleteCategory)


module.exports = router;
