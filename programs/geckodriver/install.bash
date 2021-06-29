#!/bin/bash

# Name: geckodriver
# https://github.com/mozilla/geckodriver

set -euxo pipefail

cd "$(mktemp --dir)"

sudo apt-get update

# Installer dependencies
sudo apt-get --assume-yes install \
curl \
jq

browser_download_url=$(
  curl -Ss 'https://api.github.com/repos/mozilla/geckodriver/releases/latest' |
  jq -r '.assets[] | select(.name | test("linux64.tar.gz$")) | .browser_download_url'
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

sudo mv geckodriver /usr/local/bin

geckodriver --version
