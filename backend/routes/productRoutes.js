const { Router } = require('express');

const {
  getAllProducts,
  createProduct,
} = require('../controllers/productController');

const productRouter = Router();

productRouter.post('/api/products', createProduct);
productRouter.get('/api/products', getAllProducts);

module.exports = productRouter;
