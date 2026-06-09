#!/usr/bin/env bash
set -euo pipefail

# meta:update: true
# meta:description GitHub CLI — GitHub's official command-line tool
# meta:link https://cli.github.com
# meta:link https://github.com/cli/cli

source ./scripts/_helpers.sh

# Step: Add GitHub CLI signing key and APT repository
# Ref: https://github.com/cli/cli/blob/trunk/docs/install_linux.md
if [ ! -f "/etc/apt/sources.list.d/github-cli.list" ]; then
  sudo install -d -m 0755 /etc/apt/keyrings
  sudo curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg \
    -o /etc/apt/keyrings/githubcli-archive-keyring.gpg
  sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" \
    | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
  sudo apt update -y
  echo "Added GitHub CLI repository"
fi

# Step: Install or upgrade GitHub CLI
sudo apt install -y gh

echo "Installed GitHub CLI"

# Step: Install GitHub CLI extensions
# Ref: https://cli.github.com/manual/gh_extension_install
_extensions=(
  # A rich terminal UI for GitHub — https://gh-dash.dev
  "dlvhdr/gh-dash"
  # A terminal UI for interacting with GitHub — https://github.com/gizmo385/gh-lazy
  "gizmo385/gh-lazy"
)

for _ext in "${_extensions[@]}"; do
  gh extension install "$_ext"
done