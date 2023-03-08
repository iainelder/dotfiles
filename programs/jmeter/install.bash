#!/bin/bash

# Name: JMeter
# Source: https://dlcdn.apache.org/jmeter/

set -euxo pipefail

cd "$(mktemp --dir)"

sudo apt --yes install \
curl \
default-jre

latest_download="$(
  curl -Ss 'https://dlcdn.apache.org/jmeter/binaries/' \
  | grep -oP '(?<=<a href=")apache-jmeter-.*?\.tgz(?=">)' \
  | tail -1
)"

download_url="https://dlcdn.apache.org/jmeter/binaries/$latest_download"

download_filename=$(
  curl \
  --silent \
  --show-error \
  --url "${download_url}" \
  --location \
  --remote-name \
  --write-out '%{filename_effective}'
)

tar \
--extract \
--auto-compress \
--transform 's:[^/]*:jmeter:' \
--file "$download_filename"

sudo mv jmeter /opt

sudo ln -sf /opt/jmeter/bin/jmeter /usr/local/bin/jmeter

jmeter -n -v
