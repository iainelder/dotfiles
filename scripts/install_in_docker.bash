#!/bin/bash

program="${1}"

set -euxo pipefail

apt-get --yes update && apt-get --yes install sudo

# Make `apt-get install` work correctly in sudo for packages depending on those
# such as tzdata and keyboard-configuration that freeze the Docker installation
# with a prompt.
export DEBIAN_FRONTEND=noninteractive
echo "Defaults env_keep += \"DEBIAN_FRONTEND\"" >> /etc/sudoers

# Create the user's bin directory. Already exists for a normal Ubuntu user.
mkdir --parents ~/.local/bin

"${program}"
