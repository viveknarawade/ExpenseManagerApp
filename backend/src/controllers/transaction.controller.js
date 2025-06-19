const asyncHandler = require("../utils/asyncHandler.js");
const ApiError = require("../utils/ApiError.js");
const ApiResponse = require("../utils/ApiResponse.js");
const Transaction = require("../models/transaction.model.js");

const addTransaction = asyncHandler(async (req, res) => {
  const { categoryId, amount, date, description } = req.body;
  const userId = req.user._id;

  if (!categoryId || !amount || !date) {
    throw new ApiError(400, "categoryId, amount and date are required");
  }

  const transaction = await Transaction.create({
    userId,
    categoryId,
    amount,
    date,
    description,
  });

  return res
    .status(201)
    .json(new ApiResponse(201, transaction, "Transaction added successfully"));
});

const deleteTransaction = asyncHandler(async (req, res) => {
    const transactionId = req.params.id;
    const userId = req.user._id;
  
    const transaction = await Transaction.findOne({ _id: transactionId, userId });
  
    if (!transaction) {
      throw new ApiError(404, "Transaction not found");
    }
  
    transaction.isDeleted = true;
    await transaction.save(); 
  
    return res
      .status(200)
      .json(new ApiResponse(200, transaction, "Transaction deleted"));
  });
  

module.exports = { addTransaction, deleteTransaction };
