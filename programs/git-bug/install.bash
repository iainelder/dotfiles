#!/bin/bash

# https://github.com/git-bug/git-bug

set -euxo pipefail

cd "$(mktemp --dir)"

sudo apt-get update

# Installer dependencies
sudo apt-get --assume-yes install \
git \
make \
golang-go

git clone https://github.com/git-bug/git-bug.git
cd git-bug
make install

sudo mv ~/go/bin/git-bug /usr/local/bin/

git-bug version
