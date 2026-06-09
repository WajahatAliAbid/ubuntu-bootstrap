#!/usr/bin/env bash
set -euo pipefail

# meta:update: false
# meta:description Installs Google Chrome stable and the matching ChromeDriver binary
# meta:link https://www.google.com/chrome/
# meta:link https://googlechromelabs.github.io/chrome-for-testing/

source ./scripts/_helpers.sh

if command -v google-chrome &> /dev/null; then
  echo "Google Chrome already installed with version $(google-chrome --version)"
  exit 0
fi

# Step: Download and install Google Chrome stable .deb
# Ref: https://www.google.com/chrome/
_file_path=$(download_file "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb")
sudo apt install -y "$_file_path"
echo "Installed Google Chrome $(google-chrome --version)"

# Step: Resolve the matching ChromeDriver version for the installed Chrome major
# Ref: https://googlechromelabs.github.io/chrome-for-testing/
_chrome_major=$(google-chrome --version | grep -oP '\d+' | head -1)
_driver_version=$(curl --silent --fail "https://googlechromelabs.github.io/chrome-for-testing/LATEST_RELEASE_${_chrome_major}")

# Step: Download, extract, and install ChromeDriver to /usr/local/bin
_file_path=$(download_file "https://storage.googleapis.com/chrome-for-testing-public/${_driver_version}/linux64/chromedriver-linux64.zip")
sudo unzip -o "$_file_path" chromedriver-linux64/chromedriver -d /tmp/chromedriver
sudo mv /tmp/chromedriver/chromedriver-linux64/chromedriver /usr/local/bin/chromedriver
sudo chmod +x /usr/local/bin/chromedriver
echo "Installed ChromeDriver $(chromedriver --version)"