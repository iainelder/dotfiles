#!/bin/bash

# Name: aws-vault
# https://github.com/99designs/aws-vault

set -euxo pipefail

cd "$(mktemp --dir)"

sudo apt-get update

# Installer dependencies
sudo apt-get --assume-yes install \
curl \
jq

browser_download_url=$(
  curl -Ss 'https://api.github.com/repos/99designs/aws-vault/releases/latest' |
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

chmod +x "${download_filename}"
sudo cp "${download_filename}" /usr/local/bin/aws-vault


aws-vault --version
