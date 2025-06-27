#!/bin/bash

# Stop script on any error
set -e

echo "=== Stopping Application Stack ==="

# 1. Stop frontend (React) via PM2
echo "Stopping frontend..."
pm2 stop frontend --silent || echo "Frontend not running or already stopped"

# 2. Stop backend (Express) via PM2
echo "Stopping backend..."
pm2 stop backend --silent || echo "Backend not running or already stopped"

# 3. Delete PM2 processes
echo "Deleting PM2 processes..."
pm2 delete all --silent || echo "No PM2 processes to delete"

# 4. Stop MongoDB (only if running locally)
if systemctl is-active --quiet mongod; then
    echo "Stopping MongoDB..."
    sudo systemctl stop mongod
else
    echo "MongoDB not running or not managed by systemctl"
fi

# 5. Optional: Stop Nginx (uncomment if needed)
# echo "Stopping Nginx..."
# sudo systemctl stop nginx || echo "Nginx not running"

echo "=== All services stopped successfully ==="

# Show final status
echo ""
echo "Final Status:"
pm2 status || echo "PM2 not running"
echo ""
sudo systemctl status mongod --no-pager || echo "MongoDB systemctl status unavailable"