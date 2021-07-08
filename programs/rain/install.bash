#!/bin/bash

# Name: Anki
# https://github.com/aws-cloudformation/rain

set -euxo pipefail

cd "$(mktemp --dir)"

sudo apt-get update

# Installer dependencies
sudo apt-get --assume-yes install \
curl \
jq \
unzip

browser_download_url=$(
  curl -Ss 'https://api.github.com/repos/aws-cloudformation/rain/releases/latest' |
  jq -r '.assets[] | select(.name | test("linux-amd64.zip")) | .browser_download_url'
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

unzip "$download_filename"

extract_folder=$(basename "$download_filename" ".zip")

cd "$extract_folder"

sudo cp rain /usr/local/bin

rain --version
