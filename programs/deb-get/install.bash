#!/bin/bash

# Name: deb-get

set -euxo pipefail

cd "$(mktemp --dir)"

sudo apt-get update

sudo apt-get install --yes curl lsb-release wget

curl -sL https://raw.githubusercontent.com/wimpysworld/deb-get/main/deb-get |
sudo -E bash -s install deb-get
