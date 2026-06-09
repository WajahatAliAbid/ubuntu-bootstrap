#!/usr/bin/env bash
set -euo pipefail

# meta:update: true
# meta:description An extremely fast Python linter and code formatter, written in Rust
# meta:link https://docs.astral.sh/ruff/
# meta:link https://github.com/astral-sh/ruff

source ./scripts/_helpers.sh

# Step: Install ruff via pipx
# Ref: https://docs.astral.sh/ruff/installation/
install_pip_tool "ruff"