#!/bin/bash

echo "Starting Metabase OSS..."

# Check if Docker is running
if ! docker info > /dev/null 2>&1; then
    echo "Docker is not running. Starting Docker..."
    open -a Docker
    
    # Wait for Docker to start
    echo "Waiting for Docker to start..."
    while ! docker info > /dev/null 2>&1; do
        sleep 2
    done
    echo "Docker started!"
fi

# Stop and remove existing container if it exists
docker stop metabase 2>/dev/null
docker rm metabase 2>/dev/null

# Pull latest image
echo "Pulling latest Metabase image..."
docker pull metabase/metabase:latest

# Start Metabase
echo "Starting Metabase container..."
docker run -d -p 3000:3000 --name metabase metabase/metabase

# Wait for Metabase to be ready
echo "Waiting for Metabase to start..."
sleep 10

# Open in browser
echo "Opening Metabase in your browser..."
open http://localhost:3000