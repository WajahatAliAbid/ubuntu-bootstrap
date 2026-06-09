#!/usr/bin/env bash
set -euo pipefail

# meta:update: true
# meta:description Claude Code is an agentic coding tool that lives in your terminal, understands your codebase, and can edit files, run commands, and more
# meta:link https://claude.ai/code
# meta:link https://code.claude.com/docs/en/setup#install-with-linux-package-managers

source ./scripts/_helpers.sh

# Step: Add Claude Code signing key and APT repository
# Ref: https://code.claude.com/docs/en/setup#install-with-linux-package-managers
# Note: Verify key fingerprint after install: gpg --show-keys /etc/apt/keyrings/claude-code.asc
#       Should report: 31DD DE24 DDFA B679 F42D 7BD2 BAA9 29FF 1A7E CACE
if [ ! -f "/etc/apt/sources.list.d/claude-code.list" ]; then
  sudo install -d -m 0755 /etc/apt/keyrings
  sudo curl -fsSL https://downloads.claude.ai/keys/claude-code.asc \
    -o /etc/apt/keyrings/claude-code.asc
  echo "deb [signed-by=/etc/apt/keyrings/claude-code.asc] https://downloads.claude.ai/claude-code/apt/stable stable main" \
    | sudo tee /etc/apt/sources.list.d/claude-code.list > /dev/null
  sudo apt update -y
  echo "Added Claude Code repository"
fi

# Step: Install or upgrade Claude Code
# Ref: https://code.claude.com/docs/en/setup#install-with-linux-package-managers
sudo apt install -y claude-code

echo "Installed Claude Code"