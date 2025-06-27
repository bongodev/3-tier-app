module.exports = {
  apps: [
    {
      name: "backend",
      script: "./backend/server.js",
      cwd: "/opt/app",
      env: {
        NODE_ENV: "development",
        PORT: 5000,
        MONGO_URI: process.env.MONGO_URI || 'mongodb://127.0.0.1:27017/product',
      },
      error_file: "/opt/app/logs/backend/error.log",
      out_file: "/opt/app/logs/backend/output.log",
    },
    {
      name: "frontend",
      script: "npm",
      args: "start",
      cwd: "/opt/app/frontend",
      env: {
        PORT: 3000,
      },
      error_file: "/opt/app/logs/frontend/error.log",
      out_file: "/opt/app/logs/frontend/output.log",
    },
  ],
};