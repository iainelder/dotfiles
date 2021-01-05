#!/bin/bash -eu

# Adapted from official instructions.
# https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2-linux.html

pushd "$(mktemp --directory)"

curl \
--url 'https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip' \
--output awscliv2.zip

unzip awscliv2.zip

./aws/install \
--install-dir ~/.local/aws-cli \
--bin-dir ~/.local/bin \
--update

popd
