#!/bin/bash

# Name: BorgBackup
# https://borgbackup.readthedocs.io/en/stable/installation.html

set -euxo pipefail

cd "$(mktemp --dir)"

sudo apt-get update

# Installer dependencies
sudo apt-get --assume-yes install \
curl \
jq

browser_download_url=$(
  curl -Ss 'https://api.github.com/repos/borgbackup/borg/releases/latest' |
  jq -r '.assets[] | select(.name | test("^borg-linux-glibc231$")) | .browser_download_url'
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

sudo install -T "$download_filename" /usr/local/bin/borg

borg --version
