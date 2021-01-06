#!/bin/bash -eux

repo="$(pwd)"

pushd "$(mktemp --directory)"

wget https://github.com/bats-core/bats-assert/archive/master.zip -O assert.zip
unzip assert.zip
mv bats-assert-master/ "${repo}"/bats-assert/

wget https://github.com/bats-core/bats-support/archive/master.zip -O support.zip
unzip support.zip
mv bats-support-master/ "${repo}"/bats-support/

popd
