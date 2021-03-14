#!/bin/bash

# Name: Bitbucket Pipelines CLI

set -euxo pipefail

# for tzdata
export DEBIAN_FRONTEND=noninteractive

apt-get update && apt-get --yes install \
php-yaml \
composer

PATH=~/.composer/vendor/bin:"${PATH}"

composer global require ktomk/pipelines

pipelines --version
