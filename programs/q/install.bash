#!/bin/bash

# Name: q
# https://github.com/harelba/q

set -euxo pipefail

cd "$(mktemp --dir)"

sudo apt-get update

# Installer dependencies
sudo apt-get --assume-yes install \
curl \
jq

browser_download_url=$(
  curl -Ss 'https://api.github.com/repos/harelba/q/releases/latest' |
  jq -r '.assets[] | select(.name | test("x86_64.deb")) | .browser_download_url'
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

sudo apt install "$(realpath "${download_filename}")"
