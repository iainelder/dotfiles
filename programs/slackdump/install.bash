#!/bin/bash

# Name: slackdump
# https://github.com/rusq/slackdump

set -euxo pipefail

cd "$(mktemp --dir)"

sudo apt-get update

# Installer dependencies
sudo apt-get --assume-yes install \
curl \
jq \
zstd

browser_download_url=$(
  curl -Ss 'https://api.github.com/repos/rusq/slackdump/releases/latest' |
  jq -r '.assets[] | select(.name | test("slackdump_.*_linux_amd64.pkg.tar.zst")) | .browser_download_url'
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

sudo mv usr/bin/slackdump /usr/bin/slackdump

slackdump version
