#!/bin/bash

set -e

echo "Starting Image Gallery application..."

systemctl daemon-reload
systemctl start image-gallery

sleep 5

if systemctl is-active --quiet image-gallery; then
    echo "Image Gallery application started successfully."
else
    echo "ERROR: Image Gallery application failed to start."
    systemctl status image-gallery --no-pager
    exit 1
fi
