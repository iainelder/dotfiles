#!/bin/bash

# https://docs.microsoft.com/es-es/cli/azure/install-azure-cli-linux?view=azure-cli-latest&pivots=apt

set -euxo pipefail

sudo apt-get update && sudo apt-get install --yes \
curl

curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

sudo az extension add --system --upgrade --name azure-devops

az --version

# Fix bug in az devops login
# https://github.com/Azure/azure-devops-cli-extension/issues/1099
# https://github.com/Azure/azure-cli/issues/16858
sudo apt-get install --yes python3-pip
sudo pip3 install --upgrade pip --target /opt/az/lib/python3.6/site-packages/

# Test command only works interactively.

# Interactive output: "Failed to store PAT using keyring; falling back to file storage."
# Scripted output: "Unable to use secure credential store in this environment. ... An error occurred. Pip failed with status code 2 for package keyring~=17.1.1. Use --debug for more information."
# echo "faketoken" | az devops login --debug
# az devops logout
