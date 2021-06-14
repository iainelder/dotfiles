#!/bin/bash

# Name: aws-nuke
# https://github.com/rebuy-de/aws-nuke/releases/

set -euxo pipefail

cd "$(mktemp --dir)"

sudo apt-get update

# Installer dependencies
sudo apt-get --assume-yes install \
curl \
jq

browser_download_url=$(
  curl -Ss 'https://api.github.com/repos/rebuy-de/aws-nuke/releases/latest' |
  jq -r '.assets[] | select(.name | test("linux-amd64")) | .browser_download_url'
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

executable=$(basename "$download_filename" ".tar.gz")

sudo cp "${executable}" /usr/local/bin/aws-nuke

aws-nuke version
