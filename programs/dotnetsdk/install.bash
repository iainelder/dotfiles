#!/bin/bash

# Name: .NET SDK
# https://learn.microsoft.com/en-us/dotnet/core/install/linux-ubuntu

set -euxo pipefail

cd "$(mktemp --dir)"

sudo apt-get update

install24() {
    set -euxo pipefail

    sudo apt-get --assume-yes install \
    software-properties-common

    sudo add-apt-repository --yes --ppa ppa:dotnet/backports

    sudo apt-get update
    sudo apt-get install -y dotnet-sdk-9.0

    dotnet --version
}

install20() {
    set -euxo pipefail

    # Installer dependencies
    sudo apt-get --assume-yes install \
    wget \
    lsb-release \
    moreutils # For sponge.

    dist="$(lsb_release --release --short)"

    if [[ "$dist" = "22.04" ]]; then
    sudo sponge /etc/apt/preferences.d/dotnet.pref <<"EOF"
Package: dotnet* aspnet* netstandard*
Pin: origin "archive.ubuntu.com"
Pin-Priority: -10

Package: dotnet* aspnet* netstandard*
Pin: origin "security.ubuntu.com"
Pin-Priority: -10
EOF
    fi

    wget "https://packages.microsoft.com/config/ubuntu/$dist/packages-microsoft-prod.deb" -O packages-microsoft-prod.deb
    sudo dpkg -i packages-microsoft-prod.deb
    rm packages-microsoft-prod.deb

    sudo apt-get update

    sudo apt-get install -y dotnet-sdk-7.0

    dotnet --version
}

sudo apt-get --assume-yes install lsb-release

dist="$(lsb_release --release --short)"

if [[ $dist = "20.04" || $dist = "22.04" ]]; then
    install20
else
    install24
fi
