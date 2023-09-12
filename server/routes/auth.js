const express = require("express");
const User = require("../models/user");
const authRouter = express.Router();
const bcryptjs = require("bcryptjs");

authRouter.post("/api/signup", async (req, res) => {
  try {
    const { name, email, password } = req.body;
    const existingUser = await User.findOne({ email });
    if (existingUser) {
      return res
        .status(400)
        .json({ msg: "User with same email already exists" });
    }
    let user;
    const hashedPassword = await bcryptjs.hash(password, 8);
    user = new User({
      name,
      email,
      password: hashedPassword,
    });

    user = await user.save();
    res.json({ user });
  } catch (e) {
    res.status(500).json({ error: e.message });
  }

  // get data from the client
  // post the data in  the database
  // return that data to user
});

module.exports = authRouter;
