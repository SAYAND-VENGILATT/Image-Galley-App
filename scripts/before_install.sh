#!/bin/bash

set -e

APP_DIR="/home/django-user/Image-Galley-App"
UPLOADS_DIR="$APP_DIR/app/static/uploads"
BACKUP_DIR="/tmp/image-gallery-uploads"

echo "Stopping Image Gallery application..."

systemctl stop image-gallery || true

echo "Application stopped."

echo "Checking production files..."

if [ ! -f "$APP_DIR/.env" ]; then
    echo "ERROR: Production .env file is missing!"
    exit 1
fi

if [ ! -d "$APP_DIR/venv" ]; then
    echo "ERROR: Python virtual environment is missing!"
    exit 1
fi

echo "Production .env and virtual environment exist."

echo "Backing up uploaded images..."

rm -rf "$BACKUP_DIR"
mkdir -p "$BACKUP_DIR"

if [ -d "$UPLOADS_DIR" ]; then
    cp -a "$UPLOADS_DIR/." "$BACKUP_DIR/"
fi

echo "Removing old application files..."

find "$APP_DIR" -mindepth 1 -maxdepth 1 \
    ! -name ".env" \
    ! -name "venv" \
    -exec rm -rf {} +

echo "Restoring uploaded images directory..."

mkdir -p "$UPLOADS_DIR"
cp -a "$BACKUP_DIR/." "$UPLOADS_DIR/" 2>/dev/null || true

chown -R django-user:django-user "$UPLOADS_DIR"

rm -rf "$BACKUP_DIR"

echo "BeforeInstall completed successfully."
