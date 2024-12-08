#!/bin/bash

# Name: qsv
# https://github.com/jqnatividad/qsv

# One day, I'll figure out how to depend on ghr.
# gh-release-install \
# --extract "qsv" \
# "jqnatividad/qsv" \
# "qsv-{tag}-x86_64-unknown-linux-musl.zip" \
# "${HOME}/.local/bin/qsv"

set -euxo pipefail

cd "$(mktemp --dir)"

sudo apt-get update

# Installer dependencies
sudo apt-get --assume-yes install \
curl \
jq \
unzip

# I tried the "gnu" version but qsv on Ubuntu 20.04 fails to execute with the following error:
#
# ```text
# ./qsv: /lib/x86_64-linux-gnu/libc.so.6: version `GLIBC_2.32' not found (required by ./qsv)
# ./qsv: /lib/x86_64-linux-gnu/libc.so.6: version `GLIBC_2.34' not found (required by ./qsv)
# ./qsv: /lib/x86_64-linux-gnu/libc.so.6: version `GLIBC_2.33' not found (required by ./qsv)
# ./qsv: /lib/x86_64-linux-gnu/libstdc++.so.6: version `GLIBCXX_3.4.29' not found (required by ./qsv)
# ```
#
# I have GLIBC version 2.31 here, which apparently is not favored.

browser_download_url=$(
  curl -Ss 'https://api.github.com/repos/dathere/qsv/releases/latest' |
  jq -r '.assets[] | select(.name | test("^qsv-.*?-x86_64-unknown-linux-musl.zip$")) | .browser_download_url'
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

# The musl variant is now called "qsvp". The "p" means "portable".
# I still want my installed version to be called "qsv".
# https://github.com/jqnatividad/qsv/commit/70bd244060946efe0cfd72cc663fbe5304cd4115

unzip "$download_filename" qsvp

sudo cp qsvp /usr/local/bin/qsv

qsv --version
