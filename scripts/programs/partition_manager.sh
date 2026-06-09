#!/usr/bin/env bash
set -euo pipefail

# meta:update: false
# meta:description KDE partition manager for creating, resizing, and managing disk partitions
# meta:link https://apps.kde.org/partitionmanager/
# meta:link https://github.com/KDE/partitionmanager

source ./scripts/_helpers.sh

if command -v partitionmanager &> /dev/null; then
  echo "Partition Manager already installed"
  exit 0
fi

# Step: Install KDE Partition Manager from Ubuntu default repositories
# Ref: https://apps.kde.org/partitionmanager/
sudo apt update -y
sudo apt install -y partitionmanager

echo "Installed Partition Manager"