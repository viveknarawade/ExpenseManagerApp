const mongoose = require("mongoose");

const categorySchema = mongoose.Schema(
  {
    userId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "User",
      required: true,
    },
    name: {
      type: String,
      required: true,
    },
    image: {
      type: String,
      default: "", // default value
    },
    isDeleted: {
      type: Boolean,
      default: false,
    },
  },
  { timestamps: true }
);  

const Category = mongoose.model("Category", categorySchema);
module.exports =Category 
