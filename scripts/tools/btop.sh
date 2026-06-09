#!/usr/bin/env bash
set -euo pipefail

# meta:update: false
# meta:description btop is a resource monitor showing usage and stats for processor, memory, disks, network and processes
# meta:link https://github.com/aristocratos/btop

source ./scripts/_helpers.sh

# Step: Check if btop is already installed
if command -v btop &> /dev/null; then
  echo "btop already installed"
  exit 0
fi

# Step: Install btop from Ubuntu default repositories
# Ref: https://github.com/aristocratos/btop#installation
sudo apt update -y
sudo apt install -y btop

echo "Installed btop"