#!/bin/bash -euxo pipefail

sudo apt install composer

PATH=~/.config/composer/vendor/bin:"${PATH}"

composer global require pipelines

pipelines --version
