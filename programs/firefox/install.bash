#!/bin/bash

# Name: Firefox
# https://www.omgubuntu.co.uk/2022/04/how-to-install-firefox-deb-apt-ubuntu-22-04

set -euxo pipefail

cd "$(mktemp --dir)"

sudo apt-get update

# Installer dependencies
sudo apt-get --assume-yes install \
wget

if command -v snap; then
    sudo snap remove firefox
fi

sudo install -d -m 0755 /etc/apt/keyrings

wget -q https://packages.mozilla.org/apt/repo-signing-key.gpg -O- \
| sudo tee /etc/apt/keyrings/packages.mozilla.org.asc \
> /dev/null

echo "deb [signed-by=/etc/apt/keyrings/packages.mozilla.org.asc] https://packages.mozilla.org/apt mozilla main" \
| sudo tee -a /etc/apt/sources.list.d/mozilla.list \
> /dev/null

echo '
Package: *
Pin: origin packages.mozilla.org
Pin-Priority: 1000
' \
| sudo tee /etc/apt/preferences.d/mozilla

sudo apt-get update

sudo apt install --assume-yes firefox

firefox --version
