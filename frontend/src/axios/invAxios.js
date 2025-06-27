import axios from 'axios';

import { appConfig } from '../config';

const invAxios = axios.create({
  baseURL: appConfig.BASE_URL,
  headers: {
    'Content-Type': 'application/json',
  },
});

export default invAxios;
