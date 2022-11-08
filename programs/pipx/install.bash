#!/bin/bash

# Name: Pipx

set -euxo pipefail

sudo apt-get update && sudo apt-get install --yes \
python3-pip \
python3-venv

pip3 install --user pipx

# In normal use the PATH will include the bin folder.
"$HOME"/.local/bin/pipx --version
