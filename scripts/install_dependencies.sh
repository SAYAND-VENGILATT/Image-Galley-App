#!/bin/bash

set -e

APP_DIR="/home/django-user/Image-Galley-App"
VENV="$APP_DIR/venv"

echo "Installing Python dependencies..."

if [ ! -f "$APP_DIR/requirements.txt" ]; then
    echo "ERROR: requirements.txt not found!"
    exit 1
fi

if [ ! -x "$VENV/bin/pip" ]; then
    echo "ERROR: Python virtual environment/pip not found!"
    exit 1
fi

runuser -u django-user -- "$VENV/bin/pip" install \
    --disable-pip-version-check \
    -r "$APP_DIR/requirements.txt"

echo "Setting application ownership..."

chown -R django-user:django-user "$APP_DIR/app"
chown django-user:django-user "$APP_DIR/run.py"
chown django-user:django-user "$APP_DIR/requirements.txt"

echo "Protecting production environment file..."

chown django-user:django-user "$APP_DIR/.env"
chmod 600 "$APP_DIR/.env"

echo "Dependencies installed successfully."
