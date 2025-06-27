#!/bin/bash

# Install infrastructure
/opt/app/infra/setup-mongodb.sh

# Install backend dependencies
cd /opt/app/backend
npm ci

# Install frontend dependencies and build
cd /opt/app/frontend
npm ci
npm run build

# Start services
/opt/app/scripts/start.sh