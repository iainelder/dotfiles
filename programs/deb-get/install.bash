#!/bin/bash

# Name: deb-get

set -euxo pipefail

cd "$(mktemp --dir)"

sudo apt-get update

# deb-get maps the codename to a release with /usr/share/distro-info/ubuntu.csv
# and parses the GitHub releases API with jq.
sudo apt-get install --yes curl lsb-release wget distro-info-data jq

curl -sL https://raw.githubusercontent.com/wimpysworld/deb-get/main/deb-get |
sudo -E bash -s install deb-get

deb-get version
