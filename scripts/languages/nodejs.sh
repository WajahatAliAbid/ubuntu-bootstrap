#!/usr/bin/env bash
set -euo pipefail

# meta:update: true
# meta:description Installs NVM, then installs the 5 most recent Node.js versions and sets the latest Active LTS as default
# meta:link https://github.com/nvm-sh/nvm
# meta:link https://nodejs.org/en/about/previous-releases

source ./scripts/_helpers.sh

# Step: Install NVM if not already present
# Ref: https://github.com/nvm-sh/nvm#installing-and-updating
if [ ! -d "$HOME/.nvm" ]; then
  echo "Installing nvm"
  curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/HEAD/install.sh | bash
  echo "Installed nvm"
fi

# Step: Load NVM into the current shell session
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Step: Capture the current default version before making any changes (may be empty on first run)
_previous_default=$(nvm alias default 2>/dev/null | grep -oP 'v\d+' | head -1 | sed 's/^v//' || true)

# Step: Fetch the 5 most recent Node.js major versions from the release index
# Ref: https://nodejs.org/download/release/index.json
# ⚠ VERIFY: the filter below selects ALL versions (the `or .version == .version` clause is
#   always true); replace with `select(.lts != false)` if you only want LTS majors
_node_versions=($(
  curl -fsSL https://nodejs.org/download/release/index.json \
    | jq -r '.[] | select(.lts != false or .version == .version) | .version' \
    | cut -d'.' -f1 \
    | sed 's/v//' \
    | sort -V \
    | uniq \
    | tail -n 5
))

# Step: Install each resolved major version, migrating global packages from the previous default
# Ref: https://github.com/nvm-sh/nvm#migrating-global-packages-while-installing
for _version in "${_node_versions[@]}"; do
  echo "Checking/Installing Node.js v${_version}..."
  if [[ -n "$_previous_default" ]] && nvm ls "$_version" &>/dev/null; then
    echo "Node.js v${_version} already installed, skipping"
  elif [[ -n "$_previous_default" ]]; then
    nvm install "$_version" --reinstall-packages-from="$_previous_default"
  else
    nvm install "$_version"
  fi
done

# Step: Resolve the latest Active LTS major and set it as the shell default
# Ref: https://github.com/nvm-sh/nvm#long-term-support
_latest_lts=$(
  curl -fsSL https://nodejs.org/download/release/index.json \
    | jq -r '[.[] | select(.lts != false)][0].version' \
    | cut -d'.' -f1 \
    | sed 's/v//'
)
nvm alias default "$_latest_lts"
nvm use default

echo "Installed Node.js versions: ${_node_versions[*]}"
echo "Set default Node.js version to: $_latest_lts"