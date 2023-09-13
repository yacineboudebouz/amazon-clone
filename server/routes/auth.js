const express = require("express");
const User = require("../models/user");
const authRouter = express.Router();
const bcryptjs = require("bcryptjs");
const jwt = require("jsonwebtoken");
// signUp route
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
});

// sign in route JWT

authRouter.post("/api/signin", async (req, res) => {
  try {
    const { email, password } = req.body;
    const user = await User.findOne({ email });
    if (!user) {
      return res
        .status(400)
        .json({ msg: "User wuth that email does not exist ! " });
    }
    const isMatch = await bcryptjs.compare(password, user.password);
    //
    if (!isMatch) {
      return res.status(400).json({ msg: "Icorrect password !" });
    }
    //
    const token = jwt.sign({ id: user._id }, "passwordKey");
    res.json({ token, ...user._doc });
    //
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

module.exports = authRouter;
