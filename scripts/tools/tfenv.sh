#!/usr/bin/env bash
set -euo pipefail

# meta:update: true
# meta:description tfenv — Terraform version manager
# meta:link https://github.com/tfutils/tfenv

source ./scripts/_helpers.sh

# Step: Clone tfenv repository to ~/.tfenv
# Ref: https://github.com/tfutils/tfenv#manual
echo "Installing tfenv"
if [ -d "$HOME/.tfenv" ]; then
  rm -rf "$HOME/.tfenv"
fi
git clone --depth=1 https://github.com/tfutils/tfenv.git "$HOME/.tfenv"
rm -rf "$HOME/.tfenv/.git"

echo "Installed tfenv"