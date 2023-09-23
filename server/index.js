// import from packages
const express = require("express");
const mongoose = require("mongoose");
// import from other files
const authRouter = require("./routes/auth");
const adminRouter = require("./routes/admin");

// init
const PORT = 3000;
const app = express();
const db =
  "mongodb+srv://yacineboudebbouz7:CerxP114TvGqoU1f@cluster0.vwhv7ga.mongodb.net/?retryWrites=true&w=majority";

// middleware
// client -> middleware -> server -> client
app.use(express.json());
app.use(authRouter);
app.use(adminRouter);

// connections
mongoose
  .connect(db)
  .then(() => {
    console.log("Connection Succesful");
  })
  .catch((e) => {
    console.log(e);
  });

// GET, PUT, POST, DELETE, UPDATE -> CRUD
// app.get("/", (req, res) => {
//   res.json({ hh: "Hello World" });
// });
app.listen(PORT, () => {
  console.log("connected at port " + PORT);
});
