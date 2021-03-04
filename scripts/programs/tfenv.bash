#!/bin/bash

# https://github.com/tfutils/tfenv/blob/master/README.md

command -v terraform && {
  echo >&2 "Is Terraform installed from Hashicorp's apt repo?"
  echo >&2 "Uninstall Terraform before installed tfenv."
  exit 1
}

set -euxo pipefail

cd "$(mktemp --dir)"

sudo apt-get update && sudo apt-get install --yes \
git \
curl \
unzip

git clone https://github.com/tfutils/tfenv.git ~/tfenv

ln -s ~/tfenv/bin/* ~/.local/bin/

~/.local/bin/tfenv install latest

~/.local/bin/tfenv use latest

~/.local/bin/terraform version
