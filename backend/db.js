const mongoose = require('mongoose');

const MONGO_URI = process.env.MONGO_URI || 'mongodb://127.0.0.1:27017/product';

async function connectDatabase() {
  try {
    await mongoose.connect(MONGO_URI);
    console.log('Database connection successful!!!!');
  } catch (error) {
    console.log(`Database connection failed ${MONGO_URI}`, error);
  }
}

module.exports = connectDatabase;
