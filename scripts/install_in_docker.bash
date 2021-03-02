#!/bin/bash

program="${1}"

set -euxo pipefail

apt -y update && apt -y install sudo

# Make `apt-get install` work correctly in sudo for packages depending on those
# such as tzdata and keyboard-configuration that freeze the Docker installation
# with a prompt.
export DEBIAN_FRONTEND=noninteractive
echo "Defaults env_keep += \"DEBIAN_FRONTEND\"" >> /etc/sudoers

"${program}"
