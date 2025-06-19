const asyncHandler = require("../utils/asyncHandler.js");
const ApiError = require("../utils/ApiError.js");
const ApiResponse = require("../utils/ApiResponse.js");
const uploadOnCloudinary = require("../utils/cloudinary.js");
const Category = require("../models/categories.model.js");

const addCategories = asyncHandler(async (req, res) => {
  const { name } = req.body;
  const userId = req.user._id;

  // 1. Validate fields
  if (!name?.trim()) {
    throw new ApiError(400, "Category name is required");
  }

  // 2. Check for duplicate category for the same user
  const existingCategory = await Category.findOne({
    name,
    userId,
    isDeleted: false,
  });
  if (existingCategory) {
    throw new ApiError(409, "Category with this name already exists");
  }

  // 3. Image file
  const imageLocalPath = req.files?.image?.[0]?.path;
  console.log("FILES:", req.files);

  if (!imageLocalPath) {
    throw new ApiError(400, "Category image is required");
  }

  // 4. Upload to Cloudinary
  const cloudinaryImage = await uploadOnCloudinary(imageLocalPath);
  if (!cloudinaryImage?.url) {
    throw new ApiError(500, "Image upload failed");
  }

  // 5. Create category
  const category = await Category.create({
    userId,
    name,
    image: cloudinaryImage.url,
    
  });

  return res
    .status(201)
    .json(new ApiResponse(201, category, "Category created successfully"));
});

const getCategories = asyncHandler(async (req, res) => {
  const userId = req.user._id;

  // Fetch only active categories
  const categories = await Category.find({ userId, isDeleted: false });

  return res
    .status(200)
    .json(
      new ApiResponse(200, categories, "Category Data fetched successfully")
    );
});

const softDeleteCategory = asyncHandler(async (req, res) => {
  const userId = req.user._id;

  const categoryId = req.params.id;

  const category = await Category.findOne({ _id: categoryId, userId });
  if (!category) {
    throw new ApiError(404, "Category not found");
  }

  category.isDeleted = true;
  await category.save();
  return res
    .status(200)
    .json(new ApiResponse(200, category, "Category moved to trash"));
});
module.exports = { addCategories, getCategories ,softDeleteCategory};
