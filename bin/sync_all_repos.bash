#!/bin/bash

set -euxo pipefail

sync_repos() {
  cd "${1}"

  # Set awk's field separator to handle long names that fuse with the colon.
  # ./aws-sa-pro                            : Clean
  # ./aws-sam-cli                           : Clean
  # ./aws-security-reference-architecture-examples: Changes
  # ./aws-solutions-architect-professional  : Clean
  # ./awscurl                               : Clean
  #
  # `--print-asap` avoids printing a "Waiting" message before the final
  # result that breaks the filter. `--workers 1` maintains the serial
  # execution order.
  # https://github.com/mnagel/clustergit/blob/78c4562e3e47253dccc91d49f1f1bd24d18a4fc2/clustergit#L525
  # https://github.com/mnagel/clustergit/issues/38
  unclean="$(
    clustergit \
    --print-asap --workers 1 \
    --branch '' --recursive --exclude=/\.terraform/ |
    awk -F'\\s*:' '/:/ && !/Clean/ {print $1}'
  )"

  for repo in $unclean; do
    echo "Entering ${repo} in an interactive subshell."
    echo "Finalize the working copy, git commit, and exit bash."
    (cd "${repo}" && git status && bash -li)
  done

  clustergit --branch '' --recursive --exclude=/\.terraform/ --push
}

sync_repos ~/Repos

sync_repos ~/Wikis
