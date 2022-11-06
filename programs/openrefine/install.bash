#!/bin/bash

# Name: OpenRefine
# https://github.com/OpenRefine/OpenRefine

set -euxo pipefail

cd "$(mktemp --dir)"

sudo apt-get update

# Installer dependencies
sudo apt-get --assume-yes install \
curl \
jq \
gettext-base

browser_download_url=$(
  curl -Ss 'https://api.github.com/repos/openrefine/openrefine/releases/latest' \
  | jq -r '.body' \
  | grep -oP '(?<=\[Linux\]\().*?(?=\))'
)

download_filename=$(
  curl \
  --silent \
  --show-error \
  --url "$browser_download_url" \
  --location \
  --remote-name \
  --write-out '%{filename_effective}'
)

tar --extract --gzip --file "$download_filename"

extract_folder="$(find . -mindepth 1 -maxdepth 1 -type d)"

local_path=/opt/openrefine

sudo rm -rf "${local_path}"

sudo mv "${extract_folder}" "${local_path}"

# Except local_path, all these parameters are to be expanded when loading
# the profile and not at install time. That's why EOF is in quotes to disable
# expantion. envsubst is used to expand only local_path when installing the
# shell profile.
cat > openrefine.sh <<"EOF"
export PATH="${PATH}:${local_path}"
EOF

export local_path
# shellcheck disable=SC2016,SC2002
cat openrefine.sh |
envsubst '${local_path}' |
sudo tee /etc/profile.d/openrefine.sh 1>/dev/null

# Source here to test dsutils commands.
# shellcheck disable=SC1091
source /etc/profile.d/openrefine.sh

# Application dependencies
sudo apt-get --assume-yes install \
default-jre

# The refine command has no way to print the version.
# The version number appears in the name of an internal component.
version="$(
  find /opt/openrefine/server/target/lib/ \
  -name 'openrefine-*-server.jar' \
  -printf '%f\n' \
  | grep -oP '(?<=openrefine-).*?(?=-server\.jar)'
)"

echo "$version"

# Could check that `refine -h` returns help output, but that command returns a
# non-zero exit code and I don't want to adapt Gephi's handler for that.
