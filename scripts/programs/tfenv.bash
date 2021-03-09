#!/bin/bash

# https://github.com/tfutils/tfenv/blob/master/README.md

set -euxo pipefail

dpkg-query -l terraform && {
  echo >&2 "Is Terraform installed from Hashicorp's apt repo?"
  echo >&2 "Uninstall Terraform before installing tfenv."
  exit 1
}

cd "$(mktemp --dir)"

sudo apt-get update && sudo apt-get install --yes \
git \
curl \
unzip

if ! test -d ~/tfenv; then
  git clone https://github.com/tfutils/tfenv.git ~/tfenv
else
  (cd ~/tfenv && git pull)
fi

sudo ln -s ~/tfenv/bin/* /usr/local/bin

tfenv install latest

tfenv use latest

terraform version
