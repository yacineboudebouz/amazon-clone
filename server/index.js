const express = require("express");

const PORT = 3000;

const app = express();

// creating an Api
// GET, PUT, POST, DELETE, UPDATE -> CRUD


app.listen(PORT, "0.0.0.0", () => {
  console.log("connected at port " + PORT);
});
