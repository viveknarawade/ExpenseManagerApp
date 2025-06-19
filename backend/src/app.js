const express = require("express");
const cors = require("cors");
const cookieParser = require("cookie-parser");
const app = express();

app.use(cors());
app.use(express.json({ limit: "15kb" }));
app.use(express.urlencoded({ extended: true, limit: "15kb" }));
app.use(cookieParser());

// routes import

const userRouter = require("./routes/user.routers.js");
const categoriesRouter = require("./routes/category.routers.js")
const transactionRouter = require("./routes/transaction.router.js")
const trashRouter = require("./routes/trash.router.js");


// router declaration

app.use("/api/v1/users", userRouter);
app.use("/api/v1/categories", categoriesRouter);
app.use("/api/v1/transaction", transactionRouter);
app.use("/api/v1/trash", trashRouter);


module.exports = app;
