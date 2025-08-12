# Metabase OSS

Metabase is an open source business intelligence tool. It lets you ask questions about your data, and displays answers in formats that make sense, whether that's a bar graph or a detailed table.

## Quick Start

Run the setup script to automatically start Metabase:

```bash
./setup.sh
```

This script will:
- Start Docker if it's not running
- Pull the latest Metabase Docker image
- Launch Metabase on port 3000
- Open Metabase in your browser

## Requirements

- Docker Desktop for Mac
- 2GB+ of RAM available

## Manual Docker Commands

If you prefer to run manually:

```bash
# Pull the image
docker pull metabase/metabase:latest

# Run Metabase
docker run -d -p 3000:3000 --name metabase metabase/metabase
```

Then open http://localhost:3000 in your browser.

## Documentation

For more information, visit [metabase.com](https://www.metabase.com)