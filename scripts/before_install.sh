#!/bin/bash

set -e

APP_DIR="/home/django-user/Image-Galley-App"

echo "Stopping Image Gallery application..."

systemctl stop image-gallery || true

echo "Application stopped."

echo "Checking production files..."

if [ ! -f "$APP_DIR/.env" ]; then
    echo "ERROR: Production .env file is missing!"
    exit 1
fi

echo "Production .env exists."

if [ ! -d "$APP_DIR/venv" ]; then
    echo "ERROR: Python virtual environment is missing!"
    exit 1
fi

echo "Python virtual environment exists."

if [ ! -d "$APP_DIR/app/static/uploads" ]; then
    echo "Creating uploads directory..."
    mkdir -p "$APP_DIR/app/static/uploads"
    chown django-user:django-user "$APP_DIR/app/static/uploads"
fi

echo "BeforeInstall completed successfully."
