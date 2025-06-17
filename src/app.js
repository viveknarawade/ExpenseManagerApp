const express = require("express");
const cors = require("cors");
const cookieParser = require("cookie-parser");
const app = express();

app.use(cors());
app.use(express.json({ limit: "15kb" }));
app.use(express.urlencoded({ extended: true, limit: "15kb" }));
app.use(cookieParser());

// routes import

const useRouter = require("./routes/user.routes.js");

// router declaration

app.use("/api/v1/users", useRouter);

module.exports = app;
