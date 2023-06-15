#!/bin/bash

# Name: DuckDB
# https://github.com/duckdb/duckdb/blob/master/README.md

set -euxo pipefail

cd "$(mktemp --dir)"

sudo apt-get update

sudo apt-get --assume-yes install \
curl \
jq \
unzip

browser_download_url=$(
  curl -Ss 'https://api.github.com/repos/duckdb/duckdb/releases/latest' |
  jq -r '.assets[] | select(.name == "duckdb_cli-linux-amd64.zip") | .browser_download_url'
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

unzip "${download_filename}"

sudo mv duckdb /usr/local/bin

duckdb --version
