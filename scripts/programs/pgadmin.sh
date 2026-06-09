#!/usr/bin/env bash
set -euo pipefail

# meta:update: false
# meta:description A web and desktop management tool for PostgreSQL
# meta:link https://www.pgadmin.org/
# meta:link https://www.pgadmin.org/download/pgadmin-4-apt/

source ./scripts/_helpers.sh

if command -v pgadmin4 &> /dev/null; then
  echo "pgAdmin already installed"
  exit 0
fi

# Step: Add the pgAdmin apt repository and signing key
# Ref: https://www.pgadmin.org/download/pgadmin-4-apt/
if [[ ! -f "/etc/apt/sources.list.d/pgadmin.list" ]]; then
  curl -fsS https://www.pgadmin.org/static/packages_pgadmin_org.pub \
    | sudo gpg --dearmor -o /usr/share/keyrings/pgadmin.gpg

  echo "deb [signed-by=/usr/share/keyrings/pgadmin.gpg] \
    https://ftp.postgresql.org/pub/pgadmin/pgadmin4/apt/$(lsb_release -cs) pgadmin4 main" \
    | sudo tee /etc/apt/sources.list.d/pgadmin.list

  sudo apt update -y
  echo "Added pgAdmin repository"
fi

# Step: Install pgAdmin 4
sudo apt install -y pgadmin4

echo "Installed pgAdmin"