#!/bin/bash

set -euxo pipefail

program="${1}"

script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

"${script_dir}/prepare_docker.bash"

# The session-command option is "discouraged" by the manual, but makes CTRL+C
# work in the interactive shell for debugging. It's unclear what the security
# risk is. There is some discussion here.
# https://www.suse.com/support/kb/doc/?id=000017760
# https://serverfault.com/questions/599678/what-is-the-difference-between-su-command-and-su-session-command
# https://serverfault.com/a/599827/53319
if test "_" != "${program}"; then
  # Run program install script as norm user and bash to debug after.
  su --login norm --session-command "bash --login -c '/code/${program}'; bash"
else
  # Run interactive shell for experimenting.
  su --login norm --session-command "bash --login"
fi
