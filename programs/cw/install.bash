#!/bin/bash

# Name: cw
# Source: https://github.com/lucagrulla/cw/

set -euxo pipefail

cd "$(mktemp --dir)"

sudo apt-get update

sudo apt-get --assume-yes install \
curl \
jq

browser_download_url=$(
  curl -Ss 'https://api.github.com/repos/lucagrulla/cw/releases/latest' |
  jq -r '.assets[] | select(.name == "cw_amd64.deb") | .browser_download_url'
)

package_filename=$(
  curl \
  --silent \
  --show-error \
  --url "$browser_download_url" \
  --location \
  --remote-name \
  --write-out '%{filename_effective}'
)

sudo apt-get install --yes "./${package_filename}"

cw --version
