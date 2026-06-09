#!/usr/bin/env bash
set -euo pipefail

# meta:update: false
# meta:description Docker Engine — open platform for developing, shipping, and running containerized applications
# meta:link https://docs.docker.com/engine/install/ubuntu/
# meta:link https://docs.docker.com/engine/install/linux-postinstall/

source ./scripts/_helpers.sh

# Step: Check if Docker is already installed
if command -v docker &> /dev/null; then
  echo "Docker already installed"
  exit 0
fi

# Step: Add Docker signing key and APT repository
# Ref: https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository
if [ ! -f "/etc/apt/sources.list.d/docker.list" ]; then
  sudo apt update -y
  sudo apt install -y ca-certificates curl
  sudo install -m 0755 -d /etc/apt/keyrings
  sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
    -o /etc/apt/keyrings/docker.asc
  sudo chmod a+r /etc/apt/keyrings/docker.asc
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" \
    | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  sudo apt update -y
  echo "Added Docker repository"
fi

# Step: Install Docker Engine and plugins
# Ref: https://docs.docker.com/engine/install/ubuntu/#install-docker-engine
_packages=(
  "docker-ce"
  "docker-ce-cli"
  "containerd.io"
  "docker-buildx-plugin"
  "docker-compose-plugin"
)
sudo apt install -y "${_packages[@]}"

# Step: Enable and start Docker service
# Ref: https://docs.docker.com/engine/install/linux-postinstall/
sudo systemctl enable docker.service
sudo systemctl start docker.service

# Step: Add current user to docker group (allows running docker without sudo)
sudo usermod -aG docker "$USER"

echo "Installed Docker"
echo "Note: Log out and back in for the docker group change to take effect"