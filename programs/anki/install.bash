#!/bin/bash

# Name: Anki
# https://apps.ankiweb.net/
# https://github.com/ankitects/anki/releases
# https://gist.github.com/lukechilds/a83e1d7127b78fef38c2914c4ececc3c#gistcomment-2574561
# libxcb-cinerama0: https://github.com/NVlabs/instant-ngp/discussions/300

set -euxo pipefail

cd "$(mktemp --dir)"

sudo apt-get update

# Installer dependencies
sudo apt-get --assume-yes install \
curl \
jq \
zstd \
lsb-release

browser_download_url=$(
  curl -Ss 'https://api.github.com/repos/ankitects/anki/releases/latest' |
  jq -r '.assets[] | select(.name | test("linux.tar.zst")) | .browser_download_url'
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

extract_folder=$(basename "$download_filename" ".tar.zst")

cd "anki-launcher"

# For tzdata via xdg-utils
export DEBIAN_FRONTEND=noninteractive

dist="$(lsb_release --release --short)"
if [[ $dist = "24.04" ]]; then
    libasound="libasound2t64"
else
    libasound="libasound2"
fi

# Application dependencies
sudo --preserve-env=DEBIAN_FRONTEND \
apt-get --assume-yes install \
xdg-utils \
mplayer \
libnss3 \
libxkbcommon0 \
libxdamage1 \
libxcb-xinerama0 \
"$libasound" \
libatomic1

sudo ./install.sh

anki --version
