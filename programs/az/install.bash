#!/bin/bash

# Name: Azure Devops CLI
# Source: https://docs.microsoft.com/es-es/cli/azure/install-azure-cli-linux?view=azure-cli-latest&pivots=apt

set -euxo pipefail

sudo apt-get update && sudo apt-get install --yes \
curl

curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

sudo az extension add --system --upgrade --name azure-devops

az --version

# Fix error in `az devops login` because of missing package.
# https://github.com/Azure/azure-devops-cli-extension/issues/1099
sudo apt-get install --yes python3-pip
sudo pip3 install --target /opt/az/lib/python3.6/site-packages/ keyring~=17.1.1

echo "faketoken" | az devops login
az devops logout
