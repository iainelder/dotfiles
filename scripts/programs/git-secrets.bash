#!/bin/bash

# https://github.com/awslabs/git-secrets

set -euxo pipefail

cd "$(mktemp --dir)"

sudo apt-get update && sudo apt-get install --yes \
git \
make \

git_repo_url="https://github.com/awslabs/git-secrets.git"

git_repo_local_path="${HOME}/Repos/git-secrets"

mkdir --parents "${git_repo_local_path}"

git -C "$(dirname ${git_repo_local_path})" clone "${git_repo_url}"

cd "${git_repo_local_path}"

git status

make install

# Test basic commands on self

git secrets --install

git secrets --register-aws
