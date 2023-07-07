#!/bin/bash

# Name: fzf
# https://github.com/junegunn/fzf

set -euxo pipefail

cd "$(mktemp --dir)"

sudo apt-get update

sudo apt-get --assume-yes install \
curl \
jq

browser_download_url=$(
  curl -Ss 'https://api.github.com/repos/junegunn/fzf/releases/latest' |
  jq -r '.assets[] | select(.name | test("fzf-.*?-linux_amd64.tar.gz")) | .browser_download_url'
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

tar --extract --gzip --file "$download_filename"

sudo mv fzf /usr/local/bin/fzf

fzf --version
