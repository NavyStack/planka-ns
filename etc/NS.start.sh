#!/bin/bash
set -e

max_retries=10
retry_interval=3

for ((i=1; i<=$max_retries; i++)); do
    echo "Attempt $i..."
    if node db/init.js && exec node app.js --prod "$@"; then
        echo "Application started successfully!"
        exit 0
    else
        echo "Attempt $i failed. Waiting $retry_interval seconds..."
        sleep $retry_interval
    fi
done

echo "Max retries reached. Exiting..."
exit 1