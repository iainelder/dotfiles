#!/bin/bash

# Name: Act
# https://github.com/nektos/act

set -euxo pipefail

cd "$(mktemp --dir)"

sudo apt-get update

# Installer dependencies
sudo apt-get --assume-yes install \
curl \
jq

browser_download_url=$(
  curl -Ss 'https://api.github.com/repos/nektos/act/releases/latest' |
  jq -r '.assets[] | select(.name | test("Linux_x86_64")) | .browser_download_url'
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

sudo cp act /usr/local/bin

act --version
