#!/bin/bash

# Name: identitystorelister
# https://github.com/megaproaktiv/isl/

set -euxo pipefail

cd "$(mktemp --dir)"

sudo apt-get update

# Installer dependencies
sudo apt-get --assume-yes install \
curl \
jq

browser_download_url=$(
  curl -Ss 'https://api.github.com/repos/megaproaktiv/isl/releases/latest' |
  jq -r '.assets[] | select(.name | test("^isl_.*_Linux_x86_64.tar.gz$")) | .browser_download_url'
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

sudo cp isl /usr/local/bin

md5sum isl
