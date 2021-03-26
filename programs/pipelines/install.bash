#!/bin/bash

# Name: Bitbucket Pipelines CLI

set -euxo pipefail

sudo apt-get --yes install \
php-yaml \
composer

PATH=~/.composer/vendor/bin:"${PATH}"

composer global require ktomk/pipelines

pipelines --version
