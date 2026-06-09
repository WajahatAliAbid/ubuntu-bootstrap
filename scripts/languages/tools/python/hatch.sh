#!/usr/bin/env bash
set -euo pipefail

# meta:update: true
# meta:description Modern, extensible Python project manager
# meta:link https://hatch.pypa.io
# meta:link https://github.com/pypa/hatch

source ./scripts/_helpers.sh

# Step: Install hatch via pipx
# Ref: https://hatch.pypa.io/latest/install/#pipx
install_pip_tool "hatch"