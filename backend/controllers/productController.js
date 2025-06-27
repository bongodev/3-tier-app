const Product = require('../models/product');

const createProduct = async (req, res) => {
  try {
    const newProduct = new Product(req.body);
    await newProduct.save();
    res.status(201).json(newProduct);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
};

const getAllProducts = async (req, res) => {
  const products = await Product.find();
  res.json(products);
};

module.exports = {
  createProduct,
  getAllProducts,
};
