#!/bin/bash

# Name: firefox-container
# https://github.com/honsiorovskyi/open-url-in-container

set -euxo pipefail

cd "$(mktemp --dir)"

sudo apt-get update

# Installer dependencies
sudo apt-get --assume-yes install \
curl \
jq

browser_download_url=$(
  curl -Ss 'https://api.github.com/repos/honsiorovskyi/open-url-in-container/releases/latest' |
  jq -r '.tarball_url'
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

sudo cp "$(find -name launcher.sh)" /usr/local/bin/firefox-container

firefox-container --help
