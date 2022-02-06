#!/bin/bash

set -euxo pipefail

script="${1:-_}"

# TODO: Figure out how to write a new AppArmor profile that allows mounting.
# https://lucascavalare.github.io/2020-03-15-AppArmor_Docker/

# FIXME: Still doesn't allow mounting because of AppArmor. See above.
docker run -it --rm \
--volume /var/run/docker.sock:/var/run/docker.sock \
--mount "type=bind,source=$(pwd),target=/code" \
--cap-add=SYS_ADMIN \
--cap-add=SYS_MODULE \
--device /dev/fuse \
ubuntu:20.04 \
bash -c "/code/scripts/install_in_docker.bash ${script}"

