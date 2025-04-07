#!/bin/bash

# Name: Azure CLI
# https://learn.microsoft.com/en-us/cli/azure/install-azure-cli-linux?pivots=apt
# https://learn.microsoft.com/en-us/azure/devops/cli/?view=azure-devops

set -euxo pipefail

cd "$(mktemp --dir)"

sudo apt-get update

# Installer dependencies
sudo apt-get --assume-yes install \
curl

curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

az extension add --name azure-devops

az --version
