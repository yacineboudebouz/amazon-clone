const express = require("express");
const productRouter = express.Router();
const auth = require("../middlewares/auth");
const Product = require("../models/product");

productRouter.get("/api/products", auth, async (req, res) => {
  try {
    console.log(req.query.category);
    const products = await Product.find({ category: req.query.category });
    res.json(products);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

productRouter.get(
  "/api/products/search/:searchQuery",
  auth,
  async (req, res) => {
    try {
      const products = await Product.find({
        name: { $regex: req.params.searchQuery, $options: "i" },
      });
      console.log(products);
      res.json(products);
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  }
);

module.exports = productRouter;
