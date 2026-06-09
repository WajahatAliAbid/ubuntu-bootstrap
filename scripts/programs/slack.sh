#!/usr/bin/env bash
set -euo pipefail

# meta:update: false
# meta:description Slack desktop client for Linux
# meta:link https://slack.com/
# meta:link https://packagecloud.io/slacktechnologies/slack

source ./scripts/_helpers.sh

if command -v slack &> /dev/null; then
  echo "Slack already installed"
  exit 0
fi

# Step: Add the Slack apt repository and signing key
# Ref: https://slack.com/intl/en-gb/help/articles/212924728-Download-Slack-for-Linux
if [[ ! -f "/etc/apt/sources.list.d/slack.list" ]]; then
  curl -fsSL https://packagecloud.io/slacktechnologies/slack/gpgkey \
    | sudo gpg --dearmor -o /usr/share/keyrings/slack.gpg

  echo "deb [signed-by=/usr/share/keyrings/slack.gpg] \
    https://packagecloud.io/slacktechnologies/slack/debian/ jessie main" \
    | sudo tee /etc/apt/sources.list.d/slack.list

  sudo apt update -y
  echo "Added Slack repository"
fi

# Step: Install Slack desktop
sudo apt install -y slack-desktop

echo "Installed Slack"