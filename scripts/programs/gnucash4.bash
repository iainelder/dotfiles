#!/bin/bash

# Name: GnuCash 4
# https://wiki.gnucash.org/wiki/Building_On_Linux
# https://wiki.gnucash.org/wiki/GnuCash_Sources

set -euxo pipefail

cd "$(mktemp --dir)"

## Install depdendencies

sudo sed -Ei 's/^# deb-src /deb-src /' /etc/apt/sources.list
sudo apt-get update

# GnuCash 3 dependencies
sudo apt-get build-dep --yes \
gnucash

# GnuCash 4 dependencies
sudo apt-get --yes install \
libboost-program-options1.71-dev


## Get sources

sudo apt-get --yes install \
curl

version="4.4"
name_and_version="gnucash-${version}"
tarball="${name_and_version}.tar.bz2"
source_url="https://sourceforge.net/projects/gnucash/files/gnucash%20%28stable%29/$version/${tarball}"

curl \
--silent \
--show-error \
--url "${source_url}" \
--location \
--remote-name

tar --extract --bzip2 --file "${tarball}"

source_folder="${name_and_version}"

build_folder="build-${name_and_version}"

mkdir "${build_folder}" && cd "${_}"

cmake -DCMAKE_INSTALL_PREFIX=/opt/gnucash  "../${source_folder}"

make

sudo make install

/opt/gnucash/bin/gnucash --version
