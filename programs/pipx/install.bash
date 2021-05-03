#!/bin/bash

# Name: Pipx

set -euxo pipefail

script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

sudo apt-get update && sudo apt-get install --yes \
python3-pip \
python3-venv

sudo pip3 install pipx

sudo cp "${script_dir}"/pipx.sh /etc/profile.d/pipx.sh

sudo cp "${script_dir}"/sudoers /etc/sudoers.d/pipx

# Need to source it here for the installation.
# It will be done automatically at next login.
# shellcheck disable=SC1091
source /etc/profile.d/pipx.sh

pipx --version

sudo pipx install --force print-hello-world

print-hello-world
