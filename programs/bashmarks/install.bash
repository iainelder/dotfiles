#!/bin/bash

# Name: Bashmarks
# https://github.com/huyng/bashmarks

set -euxo pipefail

cd "$(mktemp --dir)"

sudo apt-get update

# Installer dependencies
sudo apt-get --assume-yes install \
git \
make

git clone https://github.com/huyng/bashmarks

cd bashmarks

make install

# Reads environment variables `ZSH_VERSION` and `SDIRS`.
set +eu
source ~/.local/bin/bashmarks.sh

l --help
