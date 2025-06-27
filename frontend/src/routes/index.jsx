import { createBrowserRouter, RouterProvider } from 'react-router-dom';

import ProductPage from '../pages/ProductPage';
import ProductForm from '../pages/ProductForm';

const TestPage = () => (
  <div>
    <h1>Test</h1>
  </div>
);

const router = createBrowserRouter([
  {
    path: '/',
    element: <ProductPage />,
  },
  {
    path: '/create',
    element: <ProductForm />,
  },
  {
    path: '/test',
    element: <TestPage />,
  },
]);

const AppRouter = () => <RouterProvider router={router} />;

export default AppRouter;
