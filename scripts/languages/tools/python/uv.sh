#!/usr/bin/env bash
set -euo pipefail

# meta:update: true
# meta:description An extremely fast Python package and project manager, written in Rust
# meta:link https://github.com/astral-sh/uv
# meta:link https://docs.astral.sh/uv/

source ./scripts/_helpers.sh

# Step: Install uv via pipx
# Ref: https://docs.astral.sh/uv/getting-started/installation/
install_pip_tool "uv"