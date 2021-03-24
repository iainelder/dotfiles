#/bin/bash

set -euxo pipefail

cd ~/Repos

unclean="$(
  clustergit --branch '' --recursive --exclude=/\.terraform/ |
  grep ':' |
  grep -v Clean |
  awk '{print $1}'
)"

for repo in $unclean; do
  echo "Entering ${repo} in an interactive subshell."
  echo "Finalize the working copy, git commit, and exit bash."
  (cd $repo && git status && bash -li)
done

clustergit --push
