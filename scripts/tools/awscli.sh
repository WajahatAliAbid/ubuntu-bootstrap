#!/usr/bin/env bash
set -euo pipefail

# meta:update: true
# meta:description AWS CLI v2 — official command-line tool for interacting with AWS services
# meta:link https://aws.amazon.com/cli/
# meta:link https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html

source ./scripts/_helpers.sh

# Step: Download the AWS CLI v2 installer zip
# Ref: https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html
_zip=$(download_file "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" "awscli.zip")
rm -rf /tmp/aws
# Step: Unzip installer into /tmp
unzip -q "$_zip" -d /tmp/

# Step: Install or update AWS CLI depending on whether it is already present
# Ref: https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html#getting-started-install-instructions
if ! command -v aws &> /dev/null; then
  sudo /tmp/aws/install
  echo "Installed aws cli"
else
  sudo /tmp/aws/install --bin-dir /usr/local/bin --install-dir /usr/local/aws-cli --update
  echo "Updated aws cli"
fi