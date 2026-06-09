#!/usr/bin/env bash
set -euo pipefail

# meta:update: false
# meta:description Free and open source software for video recording and live streaming
# meta:link https://obsproject.com/
# meta:link https://github.com/obsproject/obs-studio

source ./scripts/_helpers.sh

if command -v obs &> /dev/null; then
  echo "OBS Studio already installed"
  exit 0
fi

# Step: Install OBS Studio from Ubuntu default repositories
# Ref: https://obsproject.com/wiki/install-instructions/linux
sudo apt update -y
sudo apt install -y obs-studio

echo "Installed OBS Studio"