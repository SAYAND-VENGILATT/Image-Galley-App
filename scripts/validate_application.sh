#!/bin/bash

set -e

echo "Validating Image Gallery application..."

for i in {1..10}; do

    if curl -fsS http://127.0.0.1:5000/ > /dev/null; then
        echo "Application is responding on port 5000."
        exit 0
    fi

    echo "Application not ready yet. Attempt $i/10..."
    sleep 3

done

echo "ERROR: Application did not respond on port 5000."

systemctl status image-gallery --no-pager

exit 1
