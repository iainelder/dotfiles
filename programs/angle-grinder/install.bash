#!/bin/bash

# Name: Angle-Grinder
# https://github.com/rcoh/angle-grinder

set -euxo pipefail

cd "$(mktemp --dir)"

sudo apt-get update

sudo apt-get --assume-yes install \
curl \
jq

browser_download_url=$(
  curl -Ss 'https://api.github.com/repos/rcoh/angle-grinder/releases/latest' |
  jq -r '.assets[] | select(.name == "agrind-x86_64-unknown-linux-gnu.tar.gz") | .browser_download_url'
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

tar -x -z -f "$download_filename"

sudo cp agrind /usr/local/bin

agrind --version
