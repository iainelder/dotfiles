#!/bin/bash

# Name: dsutils
# https://github.com/jeroenjanssens/dsutils

set -euxo pipefail

cd "$(mktemp --dir)"

sudo apt-get update && sudo apt-get install --yes \
git \
gettext-base

repo_url="https://github.com/jeroenjanssens/dsutils.git"

local_path="/opt/dsutils"

sudo mkdir --parents "${local_path}"

sudo git -C "$(dirname ${local_path})" clone "${repo_url}" || \
sudo git -C "${local_path}" pull

# Except local_path, all these parameters are to be expanded when loading
# the profile and not at install time. That's why EOF is in quotes to disable
# expantion. envsubst is used to expand only local_path when installing the
# shell profile.
cat > dsutils.sh <<"EOF"
export PATH="${PATH}:${local_path}"
EOF

export local_path
# shellcheck disable=SC2016,SC2002
cat dsutils.sh |
envsubst '${local_path}' |
sudo tee /etc/profile.d/dsutils.sh 1>/dev/null

# Source here to test dsutils commands.
# shellcheck disable=SC1091
source /etc/profile.d/dsutils.sh

# Header is the most useful command for me.
header -h
