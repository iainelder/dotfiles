#!/bin/bash

set -euxo pipefail

program="${1}"

script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

"${script_dir}/prepare_docker.bash"

if test "_" != ${program}; then
  # Run program install script as norm user and bash to debug after.
  su --login norm --command "bash --login -c '${program}'; bash"
else
  # Run interactive shell for experimenting.
  su --login norm --command "bash --login"
fi
