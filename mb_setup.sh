#!/bin/bash

echo "Starting Metabase OSS..."

# Check if Docker is running
if ! docker info >/dev/null 2>&1; then
	echo "Docker is not running. Starting Docker..."
	open -a Docker

	# Wait for Docker to start
	echo "Waiting for Docker to start..."
	while ! docker info >/dev/null 2>&1; do
		sleep 2
	done
	echo "Docker started!"
fi

# Check if container exists
if docker ps -a --format '{{.Names}}' | grep -q '^metabase$'; then
	echo "Found existing metabase container"
	if docker ps --format '{{.Names}}' | grep -q '^metabase$'; then
		echo "Metabase is already running on port $(docker port metabase 3000 | cut -d':' -f2)"
		echo "Visit http://localhost:$(docker port metabase 3000 | cut -d':' -f2)"
		exit 0
	else
		echo "Starting existing stopped container..."
		docker start metabase
		PORT=$(docker port metabase 3000 | cut -d':' -f2)
		echo "Metabase restarted on port $PORT"
		echo "Opening Metabase in your browser..."
		open http://localhost:$PORT
		exit 0
	fi
fi

# Pull latest image
echo "Pulling latest Metabase image..."
docker pull metabase/metabase:latest

# Find available port starting from 3000
PORT=3000
while lsof -i :$PORT >/dev/null 2>&1; do
	echo "Port $PORT is in use, trying next port..."
	PORT=$((PORT + 1))
done
echo "Using port $PORT for Metabase"

# Create local data directory if it doesn't exist
mkdir -p ./metabase-data

# Start Metabase with persistent data in local directory
echo "Starting Metabase container with persistent data..."
docker run -d \
  -p $PORT:3000 \
  --name metabase \
  -v "$(pwd)/metabase-data:/metabase.db" \
  metabase/metabase

# Wait for Metabase to be ready
echo "Waiting for Metabase to start..."
sleep 10

# Open in browser
echo "Opening Metabase in your browser..."
open http://localhost:$PORT
