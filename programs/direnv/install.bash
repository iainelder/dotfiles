#!/bin/bash

# Name: direnv
# https://github.com/direnv/direnv

set -euxo pipefail

cd "$(mktemp --dir)"

sudo apt-get update

sudo apt-get --assume-yes install \
curl \
jq

browser_download_url=$(
  curl -Ss 'https://api.github.com/repos/direnv/direnv/releases/latest' |
  jq -r '.assets[] | select(.name == "direnv.linux-amd64") | .browser_download_url'
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

sudo mv "${download_filename}" /usr/local/bin/direnv

direnv --version
