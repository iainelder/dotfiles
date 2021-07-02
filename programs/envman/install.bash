#!/bin/bash

# Name: Envman
# https://github.com/bitrise-io/envman

set -euxo pipefail

cd "$(mktemp --dir)"

sudo apt-get update

# Installer dependencies
sudo apt-get --assume-yes install \
curl \
jq

browser_download_url=$(
  curl -Ss 'https://api.github.com/repos/bitrise-io/envman/releases/latest' |
  jq -r '.assets[] | select(.name | test("Linux-x86_64")) | .browser_download_url'
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

chmod +x "${download_filename}"

sudo cp "${download_filename}" /usr/local/bin/envman

envman --version
