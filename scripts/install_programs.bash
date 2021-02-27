#!/bin/bash

set -euxo pipefail

script_dir=$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)

for prog in "${script_dir}"/programs/*.bash; do
  "${prog}"
done
