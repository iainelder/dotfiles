#!/bin/bash

# https://docs.microsoft.com/es-es/cli/azure/install-azure-cli-linux?view=azure-cli-latest&pivots=apt

set -euxo pipefail

sudo apt-get update && sudo apt-get install --yes \
curl

curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

az extension add --name azure-devops

az --version
