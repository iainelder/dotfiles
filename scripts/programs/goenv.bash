#!/bin/bash

# Name: goenv
# Source: https://github.com/syndbg/goenv/blob/master/INSTALL.md

set -euxo pipefail

cd "$(mktemp --dir)"

sudo apt --yes install \
git \
gettext-base

repo_url="https://github.com/syndbg/goenv.git"
export local_path="/opt/goenv" # exported for envsubst

if ! test -d "${local_path}"; then
  sudo git clone "${repo_url}" "${local_path}"
else
  sudo git -C "${local_path}" pull
fi

# Except local_path, all these parameters are to be expanded when loading
# the profile and not at install time. That's why EOF is in quotes to disable
# expantion. envsubst is used to expand only local_path when installing the
# shell profile.
# 
# The original instructions set GOENV_ROOT to the same location as local_path.
# When installing goenv outside of the home folder, GOENV_ROOT should still
# be in the home folder.
cat > goenv.sh <<"EOF"
export GOENV_ROOT=${HOME}/.goenv
export PATH="${PATH}:${local_path}/bin"
eval "$(goenv init -)"
export PATH="${PATH}:${GOROOT}/bin"
export PATH="${PATH}:${GOPATH}/bin"
EOF


cat goenv.sh |
envsubst '${local_path}' |
sudo tee /etc/profile.d/goenv.sh 1>/dev/null

# Required for goenv install
sudo apt --yes install \
curl

# Source here to test goenv command.
# Tolerate unset GOROOT and GOPATH.
set +u
source /etc/profile
set -u

goenv --version
