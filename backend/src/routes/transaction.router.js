const express = require("express");
const router = express.Router();

const { addTransaction, deleteTransaction } = require("../controllers/transaction.controller.js");
const verifyJWT = require("../middlewares/auth.middleware.js");

// POST /api/v1/transaction
router.post("/", verifyJWT, addTransaction);

// PATCH /api/v1/transaction/:id
router.patch("/:id", verifyJWT, deleteTransaction);

module.exports = router;
