#!/bin/bash

set -euxo pipefail

script_dir=$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)

for prog in "${script_dir}"/../programs/**/install.bash; do
  "${prog}"
done
