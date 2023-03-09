#!/bin/bash

# Name: firefox-container
# https://github.com/honsiorovskyi/open-url-in-container

set -euxo pipefail

cd "$(mktemp --dir)"

sudo apt-get update

# Installer dependencies
sudo apt-get --assume-yes install \
curl \
jq

browser_download_url=$(
  curl -Ss 'https://api.github.com/repos/honsiorovskyi/open-url-in-container/releases/latest' |
  jq -r '.tarball_url'
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

sudo cp "$(find -name launcher.sh)" /usr/local/bin/firefox-container

set +e
firefox-container --help
exit_code="$?"
set -e

# The help option exits with 1 for successful output.
# Translate it to a 0.
if test 1 = "$exit_code"; then
  exit 0
fi

# If that ever gets fixed so that it exits with 0, detect it so I can fix this script.
# Translate a 0 to 1 to fail this script and make me fix it.
if test 0 -ne "$exit_code"; then
  exit 1
fi

# Otherwise, the error code was some other non-zero value. Exit with it.
exit "$exit_code"
