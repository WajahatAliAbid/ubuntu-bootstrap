#!/usr/bin/env bash
set -euo pipefail

# meta:update: false
# meta:description cloc counts blank lines, comment lines, and physical lines of source code in many programming languages
# meta:link https://github.com/AlDanial/cloc
# meta:link https://github.com/AlDanial/cloc#apt-package-manager

source ./scripts/_helpers.sh

# Step: Check if cloc is already installed
if command -v cloc &> /dev/null; then
  echo "cloc already installed"
  exit 0
fi

# Step: Install cloc from Ubuntu default repositories
# Ref: https://github.com/AlDanial/cloc#apt-package-manager
sudo apt update -y
sudo apt install -y cloc

echo "Installed cloc"