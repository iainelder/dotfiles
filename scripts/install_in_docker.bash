#!/bin/bash

set -euxo pipefail

program="${1}"

script_dir=$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)

"${script_dir}/prepare_docker.bash"

# Run program install script as norm user.
su --login norm --command "bash --login -c '$(realpath "${program}")'"
