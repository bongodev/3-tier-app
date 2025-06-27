#!/bin/bash

# Start MongoDB if not running
sudo systemctl start mongodb

# Start application with PM2
pm2 start /opt/app/ecosystem.config.js

# Save PM2 process list
pm2 save