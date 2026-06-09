#!/usr/bin/env bash
set -euo pipefail

# meta:update: false
# meta:description PostgreSQL client libraries and tools for Ubuntu
# meta:link https://www.postgresql.org
# meta:link https://www.postgresql.org/download/linux/ubuntu/

source ./scripts/_helpers.sh

# Step: Check if psql is already installed
if command -v psql &> /dev/null; then
  echo "postgresql-client already installed"
  exit 0
fi

# Step: Install PostgreSQL client tools and development libraries
# Ref: https://www.postgresql.org/download/linux/ubuntu/
_packages=(
  "postgresql-client"
  "postgresql-client-common"
  "libpq-dev"
)

sudo apt install -y "${_packages[@]}"

echo "Installed PostgreSQL"