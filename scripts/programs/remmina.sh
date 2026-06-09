#!/usr/bin/env bash
set -euo pipefail

# meta:update: false
# meta:description The GTK remote desktop client supporting RDP, VNC, and more
# meta:link https://remmina.org/
# meta:link https://github.com/FreeRDP/Remmina

source ./scripts/_helpers.sh

if command -v remmina &> /dev/null; then
  echo "Remmina already installed"
  exit 0
fi

# Step: Install Remmina and plugins from Ubuntu default repositories
# Ref: https://remmina.org/how-to-install-remmina/
_packages=(
  remmina
  remmina-plugin-exec
  remmina-plugin-rdp
  remmina-plugin-secret
  remmina-plugin-vnc
)
sudo apt update -y
sudo apt install -y "${_packages[@]}"

echo "Installed Remmina"