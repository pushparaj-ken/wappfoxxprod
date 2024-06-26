// errorMiddleware.js

// Define a middleware function to handle errors
const errorHandler = (err, req, res, next) => {
  // Set the response status based on the error
  const statusCode = err.statusCode || 500;

  // Customize error response for 401 Unauthorized error
  if (statusCode === 401) {
    return res.status(401).json({
      success: false,
      code: 401,
      status: err.message || 'Unauthorized',
      timestamp: new Date()
    });
  }

  if (statusCode === 404) {
    return res.status(404).json({
      success: false,
      code: 401,
      status: err.message || 'NotFoundError: Not Found',
      timestamp: new Date()
    });
  }

  if (statusCode === 200) {
    let responseData = {
      success: true,
      code: 200,
      status: err.message, // This might be better if it's a success message instead of an error message
      timestamp: new Date()
    };

    // Assuming data is stored in a variable named 'data'
    if (err.data) {
      responseData.Data = err.data;

    }
    return responseData;
  }

  // For other errors, send a generic error response
  res.status(statusCode).json({

    success: false,
    code: statusCode,
    message: err.message || 'Internal Server Error',
    timestamp: new Date()
  });
};

module.exports = errorHandler;
