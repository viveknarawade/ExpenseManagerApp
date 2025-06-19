require("dotenv").config({ path: "./.env" });

const connectDB = require("./db/DBConnection.js");

const app = require("./app.js");

// // Middleware
// app.use(express.json());

// Connect to MongoDB
connectDB()
  .then(() => {
    // Start server
    app.listen(process.env.PORT, () => {
      console.log(`🚀 Server running at http://localhost:${process.env.PORT}`);
    });
  })
  .catch((err) => {
    console.log("MONGODB connection failed !!! ", err);
  });
