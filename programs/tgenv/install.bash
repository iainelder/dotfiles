#!/bin/bash

# Name: tgenv
# Source: https://github.com/tfutils/tfenv/blob/master/README.md

set -euxo pipefail

cd "$(mktemp --dir)"

sudo apt-get update && sudo apt-get install --yes \
git # \
# curl \
# unzip

if ! test -d ~/tfenv; then
  git clone https://github.com/tfutils/tgenv.git ~/tfenv
else
  (cd ~/tgenv && git pull)
fi

sudo ln --symbolic --force ~/tgenv/bin/* /usr/local/bin

tgenv install latest

tfenv use latest

terraform version
