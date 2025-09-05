#!/bin/bash

# Name: SQLean
# https://github.com/nalgeon/sqlean/blob/main/README.md

set -euxo pipefail

cd "$(mktemp --dir)"

sudo apt-get update

sudo apt-get --assume-yes install \
curl \
jq \
unzip \
sqlite3

browser_download_url=$(
  curl -Ss 'https://api.github.com/repos/nalgeon/sqlean/releases/latest' |
  jq -r '.assets[] | select(.name == "sqlean-linux-x64.zip")| .browser_download_url'
)

download_filename="$(
  curl \
  --silent \
  --show-error \
  --url "$browser_download_url" \
  --location \
  --remote-name \
  --write-out '%{filename_effective}'
)"

unzip "$download_filename"

if test ! -d /opt/sqlean; then
  sudo mkdir /opt/sqlean
fi

sudo find /opt/sqlean -mindepth 1 -maxdepth 1 -type f -name '*.so' -delete

sudo mv *.so /opt/sqlean/

sqlite3 <<EOF
.load /opt/sqlean/math
SELECT sqrt(9);
EOF

# TODO: Detect installed version. https://github.com/nalgeon/sqlean/issues/47