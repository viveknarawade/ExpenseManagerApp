const asyncHandler = require("../utils/asyncHandler.js");
const ApiResponse = require("../utils/ApiResponse.js");
const Category = require("../models/categories.model.js");
const Transaction = require("../models/transaction.model.js");

const getTrashedItems = asyncHandler(async (req, res) => {
  const userId = req.user._id;

  const trashedCategories = await Category.find({ userId, isDeleted: true });
  const trashedTransactions = await Transaction.find({ userId, isDeleted: true }).populate("categoryId");

  return res.status(200).json(
    new ApiResponse(200, {
      trashedCategories,
      trashedTransactions,
    }, "Trashed items retrieved successfully")
  );
});

module.exports = getTrashedItems;
