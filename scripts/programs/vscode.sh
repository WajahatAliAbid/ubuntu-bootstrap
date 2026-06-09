#!/usr/bin/env bash
set -euo pipefail

# meta:update: false
# meta:description Visual Studio Code — a lightweight but powerful source code editor
# meta:link https://code.visualstudio.com/
# meta:link https://code.visualstudio.com/docs/setup/linux

source ./scripts/_helpers.sh

if command -v code &> /dev/null; then
  echo "VS Code already installed"
  exit 0
fi

# Step: Add the Microsoft apt repository and signing key
# Ref: https://code.visualstudio.com/docs/setup/linux#_debian-and-ubuntu-based-distributions
if [[ ! -f "/etc/apt/sources.list.d/vscode.list" ]]; then
  curl -fsSL https://packages.microsoft.com/keys/microsoft.asc \
    | sudo gpg --dearmor -o /usr/share/keyrings/microsoft.gpg

  echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/microsoft.gpg] \
    https://packages.microsoft.com/repos/vscode stable main" \
    | sudo tee /etc/apt/sources.list.d/vscode.list

  sudo apt update -y
  echo "Added VS Code repository"
fi

# Step: Install VS Code
sudo apt install -y code

echo "Installed VS Code"