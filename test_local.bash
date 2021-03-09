#!/bin/bash

set -euxo pipefail

script="${1}"

docker run -it --rm \
--mount "type=bind,source=$(pwd),target=/code" \
ubuntu:20.04 \
bash -c "/code/scripts/prepare_docker.bash && /code/${script}; bash"
