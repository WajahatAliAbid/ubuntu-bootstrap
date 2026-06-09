#!/usr/bin/env bash
set -euo pipefail

# meta:update: false
# meta:description Installs Python 3, pip, venv, pipx, and common development libraries via apt
# meta:link https://www.python.org/
# meta:link https://pipx.pypa.io/

source ./scripts/_helpers.sh

# Check if python3 and pipx are already installed
if command -v python3 &> /dev/null && command -v pipx &> /dev/null; then
  echo "python3 and pipx already installed"
  exit 0
fi

# Step: Install Python 3 and development dependencies from Ubuntu default repositories
# Ref: https://wiki.python.org/moin/BeginnersGuide/Download
_packages=(
  "python3"
  "python3-pip"
  "python3-venv"
  "python3-openssl"
  "python3-pytest"
  "python3-tk"
  "pipx"
  "python3-pyflakes"
  "libbz2-dev"   # needed for bzip2 support
  "libffi-dev"   # needed for cffi/typing extensions
)
sudo apt update -y
sudo apt install -y "${_packages[@]}"

echo "Installed Python"