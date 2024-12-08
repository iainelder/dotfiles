#!/bin/bash

# Name: Pipx

install20() {
    set -euxo pipefail

    sudo apt-get update
    sudo apt-get install --yes \
    python3-pip \
    python3-venv

    pip3 install --user pipx

    # In normal use the PATH will include the bin folder.
    "$HOME"/.local/bin/pipx --version
}

install24() {
    set -euxo pipefail

    sudo apt-get update
    sudo apt-get install --yes pipx

    pipx --version
}

source /etc/os-release

if [[ $VERSION_ID = "20.04" || $VERSION_ID = "22.04" ]]; then
    install20
else
    install24
fi
