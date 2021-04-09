#!/bin/bash

# Name: rclone
# Source: https://rclone.org/install/

set -euxo pipefail

cd "$(mktemp --dir)"

sudo apt-get update && sudo apt-get install --yes \
curl \
unzip

set +e
curl https://rclone.org/install.sh | sudo bash
install_err=$?
set -e

# Exit code 3 means already on latest version; 0 means installed successfully.
# Anything else is a real error.
if test 3 -ne "${install_err}" && test 0 -ne "${install_err}"; then
  exit $install_err
fi

rclone --version
