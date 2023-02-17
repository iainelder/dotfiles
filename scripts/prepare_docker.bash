#!/bin/bash

set -euxo pipefail

apt-get --yes update && apt-get --yes install sudo

# Make `apt-get install` work correctly in sudo for packages depending on those
# such as tzdata and keyboard-configuration that freeze the Docker installation
# with a prompt.
echo "export DEBIAN_FRONTEND=noninteractive" >> /etc/profile.d/noninteractive.sh
echo "Defaults env_keep += \"DEBIAN_FRONTEND\"" >> /etc/sudoers

# Create the user's bin directory. Already exists for a normal Ubuntu user.
mkdir --parents ~/.local/bin

# Create non-root user norm and add it to the passwordless sudo group.
echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
adduser --disabled-password --gecos '' norm || true
adduser norm sudo

# Authenticate GitHub API requests to increase rate limit.
cat > ~/.netrc <<EOF
machine api.github.com
login iainelder
password $GITHUB_TOKEN
EOF

# Patch existing curl calls to use netrc.
cat > /etc/profile.d/curl_netrc.sh <<"EOF"
curl() {
  command curl --netrc "$@"
}
EOF
