#!/bin/bash

set -euxo pipefail

sync_repos() {
  cd "${1}"

  # Waiting output is generated for some (slower?) repos. When the repo
  # processing is complete the line no longer appears in the terminal but it
  # remains in stdout. The '\r' means that in the terminal the line gets
  # overwritten but in the stream it's prepended to the line.
  # https://github.com/mnagel/clustergit/blob/78c4562e3e47253dccc91d49f1f1bd24d18a4fc2/clustergit#L525
  # https://github.com/mnagel/clustergit/issues/38
  unclean="$(
    clustergit --branch '' --recursive --exclude=/\.terraform/ |
    tr '\r' '\n' |
    grep ':' |
    grep -v Clean |
    awk '{print $1}'
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
