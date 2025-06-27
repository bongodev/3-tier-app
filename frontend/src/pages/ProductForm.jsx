import { useState } from 'react';
import { useNavigate } from 'react-router-dom';

import Box from '@mui/material/Box';
import TextField from '@mui/material/TextField';
import { Button } from '@mui/material';

import invAxios from '../axios/invAxios';

export default function ProductForm() {
  const navigate = useNavigate();

  const [product, setProduct] = useState({
    name: '',
    price: 0,
    quantity: 0,
  });

  const onChange = (event) => {
    setProduct({
      ...product,
      [event.target.name]: event.target.value,
    });
  };

  const routeToHome = () => navigate('/');

  const addProduct = (event) => {
    event.preventDefault();

    invAxios
      .post('/products', product)
      .then((res) => routeToHome())
      .catch((err) => {
        alert('Failed to create!!!');
        console.error(err);
      });
  };

  return (
    <form onSubmit={addProduct}>
      <Box
        sx={{
          '& .MuiTextField-root': { m: 1, width: '25ch' },
          paddingY: 16,
          display: 'flex',
          flexDirection: 'column',
          alignItems: 'center',
        }}
      >
        <TextField
          name="name"
          required
          label="Name"
          value={product.name}
          onChange={onChange}
        />
        <TextField
          name="price"
          required
          label="Price"
          type="number"
          value={product.price}
          onChange={onChange}
        />
        <TextField
          name="quantity"
          label="Quantity"
          type="number"
          value={product.quantity}
          onChange={onChange}
        />
        <Box>
          <Button variant="outlined" color="error" onClick={routeToHome}>
            Cancel
          </Button>
          <Button type="submit" variant="contained">
            Add
          </Button>
        </Box>
      </Box>
    </form>
  );
}
