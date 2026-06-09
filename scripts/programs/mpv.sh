#!/usr/bin/env bash
set -euo pipefail

# meta:update: false
# meta:description A free, open source, and cross-platform media player
# meta:link https://mpv.io/
# meta:link https://github.com/mpv-player/mpv

source ./scripts/_helpers.sh

if command -v mpv &> /dev/null; then
  echo "MPV already installed"
  exit 0
fi

# Step: Install MPV from Ubuntu default repositories
# Ref: https://mpv.io/installation/
sudo apt update -y
sudo apt install -y mpv

echo "Installed MPV"