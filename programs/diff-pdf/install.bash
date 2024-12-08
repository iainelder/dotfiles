#!/bin/bash

# Name: diff-pdf
# https://github.com/vslavik/diff-pdf

set -euxo pipefail

cd "$(mktemp --dir)"

sudo apt-get update

# Installer dependencies
sudo apt-get --assume-yes install \
curl \
jq \
lsb-release

browser_download_url=$(
  curl -Ss 'https://api.github.com/repos/vslavik/diff-pdf/releases/latest' |
  jq -r '.assets[] | select(.name | test("diff-pdf-.*?\\.tar\\.gz")) | .browser_download_url'
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

tar --extract --auto-compress --file "$download_filename" --strip-components 1

dist="$(lsb_release --release --short)"
if [[ $dist = "24.04" ]]; then
    gtk3="libwxgtk3.2-dev"
else
    gtk3="libwxgtk3.0-gtk3-dev"
fi

# Build dependencies.
sudo apt-get install --assume-yes \
make \
automake \
g++ \
libpoppler-glib-dev \
poppler-utils \
"$gtk3"

./bootstrap
./configure
make
sudo make install

# There is no version option, but help exits 0.
# Ignore the GTK initialization error.
diff-pdf --help
