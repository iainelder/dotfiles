#!/bin/bash

# Name: Cropgui
# https://github.com/jepler/cropgui

set -euxo pipefail

cd "$(mktemp --dir)"

sudo apt-get update

# Installer dependencies
sudo apt-get --assume-yes install \
curl \
unzip \
git \
lsb-release

dist="$(lsb_release --release --short)"
if [[ $dist = "24.04" ]]; then
    distutils="python3-setuptools"
else
    distutils="python3-distutils"
fi

# Application dependencies
sudo apt-get --assume-yes install \
"$distutils" \
python3-pil.imagetk \
libjpeg-progs \
libimage-exiftool-perl

git clone https://github.com/jepler/cropgui

cd cropgui

# "python3", not "python". Thanks to Murali Kodali.
# https://github.com/jepler/cropgui/issues/62#issuecomment-628392826
sudo bash ./install.sh -p /usr -P /usr/bin/python3

# It has no version option and works only in a graphical environment.
which cropgui
