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
libxml2-utils

# Get latest version URL
curl -Ss 'https://app-updates.agilebits.com/product_history/CLI' > all_versions

# nowarning doesn't seem to work, so just supress stderr
xmllint \
--html \
--xpath "(//a[starts-with(@href, 'https://cache.agilebits.com/') and contains(@href, 'linux_amd64')]/@href)[1]" \
all_versions \
> latest_version \
2>/dev/null

download_url="$(grep --only-matching --perl-regexp '(?<=href=")[^"]+' latest_version)"

download_filename=$(
  curl \
  --silent \
  --show-error \
  --url "$download_url" \
  --location \
  --remote-name \
  --write-out '%{filename_effective}'
)
