#!/bin/bash

# Name: Parallel
# https://www.gnu.org/software/parallel/

set -euxo pipefail

cd "$(mktemp --dir)"

sudo apt-get update

# Installer dependencies
sudo apt-get --assume-yes install \
curl \
jq \
make

browser_download_url="https://ftpmirror.gnu.org/parallel/parallel-latest.tar.bz2"

download_filename=$(
  curl \
  --silent \
  --show-error \
  --url "$browser_download_url" \
  --location \
  --remote-name \
  --write-out '%{filename_effective}'
)

tar --extract --auto-compress --file "$download_filename" --strip-components 1

# Steps found in extracted README.
./configure
make
sudo make install

grep -b "for each argument, run command with argument, in parallel" /usr/bin/parallel
is_moreutils="$?"

if test 0 = "$is_moreutils"; then
  sudo mv /usr/bin/parallel /usr/bin/parallel.moreutils
  printf "Moved moreutils version of parallel to /usr/bin/parallel.moreutils to avoid conflict." >&2
fi

parallel --version
