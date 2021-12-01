#!/bin/bash

# Name: s5cmd
# https://github.com/peak/s5cmd

set -euxo pipefail

cd "$(mktemp --dir)"

sudo apt-get update

# Installer dependencies
sudo apt-get --assume-yes install \
curl \
jq

browser_download_url=$(
  curl -Ss 'https://api.github.com/repos/peak/s5cmd/releases/latest' |
  jq -r '.assets[] | select(.name | test("Linux-64bit")) | .browser_download_url'
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

sudo cp s5cmd /usr/local/bin

s5cmd version
