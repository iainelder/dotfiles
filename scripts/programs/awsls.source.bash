#!/bin/bash

set -euxo pipefail

script_dir=$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)

cd "$(mktemp --dir)"

sudo apt-get install --yes \
git \
make \
gcc

"${script_dir}"/goenv.bash

set +u
source /etc/profile.d/goenv.sh
set -u

goenv install --skip-existing 1.15.8
goenv global 1.15.8

git clone https://github.com/jckuester/awsls.git
git checkout feature/upgrade-to-aws-sdk-v.1.2

go build

./awsls --version