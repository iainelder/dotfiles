#!/bin/bash
set -euxo pipefail

sudo apt --assume-yes install composer

PATH=~/.config/composer/vendor/bin:"${PATH}"

composer global require pipelines

sudo apt --assume-yes install composer

pipelines --version
