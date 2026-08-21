#!/bin/bash

# Name: tlog
# https://github.com/Scribery/tlog

set -euxo pipefail

sudo apt-get update

# jq reads the tlog configuration in the record function.
sudo apt-get --assume-yes install \
jq \
tlog

tlog-rec --version
