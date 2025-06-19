class ApiError extends Error {
    constructor(
      statusCode,
      message = "Something went wrong",
      errors = [],
      stack = ""
    ) {
      super(message); // Call the parent Error constructor
  
      this.statusCode = statusCode; // HTTP status code (e.g., 400, 500)
      this.data = null;             // Placeholder for any extra data
      this.message = message;       // Error message
      this.success = false;         // Indicates failure
      this.errors = errors;         // Optional list of error details
  
      if (stack) {
        this.stack = stack;
      } else {
        Error.captureStackTrace(this, this.constructor); // captures stack trace excluding this constructor
      }
    }
  }
  
  module.exports = ApiError;
  