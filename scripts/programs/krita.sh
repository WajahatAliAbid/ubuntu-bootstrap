#!/usr/bin/env bash
set -euo pipefail

# meta:update: false
# meta:description A professional open source painting and illustration application
# meta:link https://krita.org/
# meta:link https://github.com/KDE/krita

source ./scripts/_helpers.sh

if command -v krita &> /dev/null; then
  echo "Krita already installed"
  exit 0
fi

# Step: Install Krita from Ubuntu default repositories
# Ref: https://krita.org/en/download/
sudo apt update -y
sudo apt install -y krita

echo "Installed Krita $(krita --version)"