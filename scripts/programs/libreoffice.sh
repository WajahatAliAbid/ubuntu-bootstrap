#!/usr/bin/env bash
set -euo pipefail

# meta:update: false
# meta:description A free and open source office productivity suite
# meta:link https://www.libreoffice.org/
# meta:link https://github.com/LibreOffice/core

source ./scripts/_helpers.sh

if command -v libreoffice &> /dev/null; then
  echo "LibreOffice already installed"
  exit 0
fi

# Step: Install LibreOffice from Ubuntu default repositories
# Ref: https://www.libreoffice.org/get-help/install-howto/linux/
sudo apt update -y
sudo apt install -y libreoffice

echo "Installed LibreOffice"