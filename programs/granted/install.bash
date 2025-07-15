#!/bin/bash

# Name: Granted
# https://github.com/common-fate/granted

set -euxo pipefail

cd "$(mktemp --dir)"

sudo apt-get update

# Installer dependencies
sudo apt-get --assume-yes install \
curl \
jq

browser_download_url=$(
  curl -Ss 'https://api.github.com/repos/fwdcloudsec/granted/releases/latest' |
  jq -r '.assets[] | select(.name | test("granted_.*?_linux_x86_64.tar.gz")) | .browser_download_url'
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

tar --extract --auto-compress --file "$download_filename"

sudo cp assume assumego granted /usr/local/bin

granted --version
