#!/usr/bin/env bash
set -euo pipefail

# meta:update: false
# meta:description pyenv — simple Python version management
# meta:link https://github.com/pyenv/pyenv
# meta:link https://github.com/pyenv/pyenv#installation

source ./scripts/_helpers.sh

# Step: Check if pyenv is already installed
if [ -d "$HOME/.pyenv" ]; then
  echo "pyenv already installed"
  exit 0
fi

# Step: Install pyenv via the official installer
# Ref: https://github.com/pyenv/pyenv#automatic-installer
echo "Installing pyenv"
curl https://pyenv.run | bash

echo "Installed pyenv"