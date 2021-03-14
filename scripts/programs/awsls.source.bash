#!/bin/bash

set -euxo pipefail

cd "$(mktemp --dir)"

script_dir=$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)

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

(cd awsls && make ci)
