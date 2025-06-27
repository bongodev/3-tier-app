#!/bin/bash
set -e  # Exit on error

# Configuration
BACKUP_DIR="/opt/app/backups"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
BACKUP_NAME="app_backup_$TIMESTAMP"
BACKUP_PATH="$BACKUP_DIR/$BACKUP_NAME"

# Create backup directory if it doesn't exist
mkdir -p "$BACKUP_PATH"

echo "=== Starting Backup: $(date) ==="
echo "Backup destination: $BACKUP_PATH"

# 1. Backup MongoDB
echo "Backing up MongoDB..."
mongodump --uri="mongodb://localhost:27017" \
        #   --username=adminUser \
        #   --password=adminPassword123 \
          --out="$BACKUP_PATH/mongodb" \
          --quiet

# 2. Backup frontend build
echo "Backing up frontend build..."
mkdir -p "$BACKUP_PATH/frontend"
cp -r /var/www/html/* "$BACKUP_PATH/frontend/"

# 3. Backup backend code and node_modules
echo "Backing up backend..."
mkdir -p "$BACKUP_PATH/backend"
rsync -a --exclude='node_modules' /opt/app/backend/ "$BACKUP_PATH/backend/"

# 4. Backup important configurations
echo "Backing up configurations..."
mkdir -p "$BACKUP_PATH/configs"
cp /etc/nginx/sites-available/your-app "$BACKUP_PATH/configs/nginx.conf"
cp /opt/app/ecosystem.config.js "$BACKUP_PATH/configs/"
cp /opt/app/.mongo.env "$BACKUP_PATH/configs/"

# 5. Create compressed archive
echo "Creating compressed archive..."
tar -czf "$BACKUP_DIR/$BACKUP_NAME.tar.gz" -C "$BACKUP_DIR" "$BACKUP_NAME"

# 6. Cleanup temporary files
rm -rf "$BACKUP_PATH"

# 7. Rotate old backups (keep last 7 days)
find "$BACKUP_DIR" -name "app_backup_*.tar.gz" -mtime +7 -delete

echo "=== Backup Completed ==="
echo "Archive created: $BACKUP_DIR/$BACKUP_NAME.tar.gz"
echo "Backup size: $(du -h "$BACKUP_DIR/$BACKUP_NAME.tar.gz" | cut -f1)"