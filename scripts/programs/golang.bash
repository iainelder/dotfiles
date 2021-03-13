#!/bin/bash

set -euxo pipefail

cd "$(mktemp --dir)"

sudo apt-get --yes install software-properties-common

sudo add-apt-repository --yes --update ppa:longsleep/golang-backports

sudo apt-get --yes install golang

go version
