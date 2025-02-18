#!/bin/bash

# Name: awscli
# Source: https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2-linux.html

set -euxo pipefail

cd "$(mktemp --dir)"

sudo apt-get install --yes \
curl \
jq \
unzip

curl "https://s3.amazonaws.com/session-manager-downloads/plugin/latest/ubuntu_64bit/session-manager-plugin.deb" \
-o "session-manager-plugin.deb"

sudo dpkg -i session-manager-plugin.deb

session-manager-plugin --version
