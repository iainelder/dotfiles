#!/bin/bash

# Name: DVC (Data Version Control)
# https://dvc.org/doc/install/linux

set -euxo pipefail

cd "$(mktemp --dir)"

sudo apt-get update

# Installer dependencies
sudo apt-get --assume-yes install \
wget \
gnupg

wget --quiet https://dvc.org/deb/dvc.list -O dvc.list
sudo cp dvc.list /etc/apt/sources.list.d/

wget --quiet -O - https://dvc.org/deb/iterative.asc | sudo apt-key add -

sudo apt-get update

sudo apt-get --assume-yes install \
dvc

dvc --version
