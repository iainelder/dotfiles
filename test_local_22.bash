#!/bin/bash

set -euxo pipefail

script="${1:-_}"

docker run -it --rm \
--volume /var/run/docker.sock:/var/run/docker.sock \
--mount "type=bind,source=$(pwd),target=/code" \
ubuntu:22.04 \
bash -c "/code/scripts/install_in_docker.bash ${script}"
