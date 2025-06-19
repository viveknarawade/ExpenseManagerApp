const express = require("express");
const router = express.Router();
const verifyJWT = require("../middlewares/auth.middleware.js");
const getTrashedItems = require("../controllers/trash.controller.js");

router.get("", verifyJWT, getTrashedItems); // /api/v1/trash

module.exports = router;