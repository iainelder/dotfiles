#!/bin/bash

# Name: rclone
# Source: https://rclone.org/install/

set -euxo pipefail

cd "$(mktemp --dir)"

sudo apt-get update && sudo apt-get install --yes \
curl \
unzip

curl https://rclone.org/install.sh | sudo bash

rclone --version
