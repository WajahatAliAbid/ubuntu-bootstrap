#!/usr/bin/env bash
set -euo pipefail

# meta:update: true
# meta:description A simple terminal UI for git commands
# meta:link https://github.com/jesseduffield/lazygit
# meta:link https://github.com/catppuccin/lazygit

source ./scripts/_helpers.sh

# Step: Install lazygit via go install
# Ref: https://github.com/jesseduffield/lazygit#installation
install_go_tool "github.com/jesseduffield/lazygit"