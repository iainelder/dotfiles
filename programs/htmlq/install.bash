#!/bin/bash

# Name: Anki
# https://apps.ankiweb.net/
# https://github.com/ankitects/anki/releases
# https://gist.github.com/lukechilds/a83e1d7127b78fef38c2914c4ececc3c#gistcomment-2574561

set -euxo pipefail

cd "$(mktemp --dir)"

sudo apt-get update

# Installer dependencies
sudo apt-get --assume-yes install \
curl \
jq

browser_download_url=$(
  curl -Ss 'https://api.github.com/repos/mgdm/htmlq/releases/latest' |
  jq -r '.assets[] | select(.name | test("htmlq-x86_64-linux.tar.gz")) | .browser_download_url'
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

sudo cp htmlq /usr/local/bin

htmlq --version
