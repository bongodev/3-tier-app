import React, { useEffect, useState } from 'react';
import { useNavigate } from 'react-router-dom';

import { Box, Button } from '@mui/material';

import invAxios from '../axios/invAxios';

import ProductCard from '../components/ProductCard';

const ProductPage = () => {
  const navigate = useNavigate();
  const [products, setProducts] = useState([]);

  useEffect(() => {
    invAxios
      .get('/products')
      .then((res) => {
        setProducts(res.data);
      })
      .catch((err) => alert('Failed to fetch products!!'));
  }, []);

  const routeToProductForm = () => navigate('/create');

  return (
    <Box
      sx={{
        display: 'flex',
        flexDirection: 'column',
        justifyContent: 'center',
        alignItems: 'center',
        gap: 4,
        paddingY: 4,
      }}
    >
      <Box>
        <Button onClick={routeToProductForm} variant="contained">
          Add Product
        </Button>
      </Box>
      {products.map((product) => (
        <ProductCard key={product._id} product={product} />
      ))}
    </Box>
  );
};

export default ProductPage;
