#!/usr/bin/env bash
set -euo pipefail

# meta:update: true
# meta:description Recursively searches directories for a regex pattern while respecting gitignore
# meta:link https://github.com/BurntSushi/ripgrep

source ./scripts/_helpers.sh

# Step: Install ripgrep via cargo
# Ref: https://github.com/BurntSushi/ripgrep#installation
install_cargo_tool "ripgrep" "rg"