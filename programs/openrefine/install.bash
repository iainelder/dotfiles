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
  curl -Ss 'https://api.github.com/repos/openrefine/openrefine/releases/latest' |
  jq -r '.assets[] | select(.name | test("linux")) | .browser_download_url'
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

# Refine has no version output, so the help will do.
refine -h
