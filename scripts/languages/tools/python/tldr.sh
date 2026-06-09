#!/usr/bin/env bash
set -euo pipefail

# meta:update: true
# meta:description A Python client for tldr-pages — simplified, community-driven man pages
# meta:link https://github.com/tldr-pages/tldr
# meta:link https://github.com/tldr-pages/tldr-python-client

source ./scripts/_helpers.sh

# Step: Install tldr via pipx
# Ref: https://github.com/tldr-pages/tldr-python-client#installation
install_pip_tool "tldr"