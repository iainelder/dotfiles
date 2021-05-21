#!/bin/bash

set -euxo pipefail

sync_repos() {
  cd $1

  unclean="$(
    clustergit --branch '' --recursive --exclude=/\.terraform/ |
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
