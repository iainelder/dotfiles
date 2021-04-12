#!/bin/bash

# Name: SQLean
# https://github.com/nalgeon/sqlean/blob/main/README.md

set -euxo pipefail

cd "$(mktemp --dir)"

sudo apt-get update

sudo apt-get --assume-yes install \
curl \
jq \
sqlite3

readarray -t browser_download_urls < <(
  curl -Ss 'https://api.github.com/repos/nalgeon/sqlean/releases/latest' |
  jq -r '.assets[] | select(.name | test("\\.so$"))| .browser_download_url'
)

if test ! -d /opt/sqlean; then
  sudo mkdir /opt/sqlean
fi

for url in "${browser_download_urls[@]}"; do

  download_filename="$(
    curl \
    --silent \
    --show-error \
    --url "$url" \
    --location \
    --remote-name \
    --write-out '%{filename_effective}'
  )"

  sudo mv "${download_filename}" /opt/sqlean/
done

sqlite3 <<EOF
.load /opt/sqlean/math
SELECT sqrt(9);
EOF
