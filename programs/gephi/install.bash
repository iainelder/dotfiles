#!/bin/bash

# Name: Gephi
# https://gephi.org/

set -euxo pipefail

cd "$(mktemp --dir)"

sudo apt-get update

# Installer dependencies
sudo apt-get --assume-yes install \
curl \
jq

browser_download_url=$(
  curl -Ss 'https://api.github.com/repos/gephi/gephi/releases/latest' |
  jq -r '.assets[] | select(.name | test("linux-x64.tar.gz")) | .browser_download_url'
)

download_filename=$(
  curl \
  --silent \
  --show-error \
  --url "$browser_download_url" \
  --location \
  --remote-name \
  --write-out '%{filename_effective}'
)

tar --extract --auto-compress --file "$download_filename"

extract_folder=$(basename "$download_filename" "-linux-x64.tar.gz")

sudo mv "${extract_folder}" /opt/gephi

sudo ln -sf /opt/gephi/bin/gephi /usr/local/bin/gephi

# There is no `--version` option. Any of the `org.gephi` modules report the
# public version, so we parse that out from the modules list.
#
# In a graphical environment this actually launches the GUI. The GUI needs to be
# closed for the version number to appear and this script to complete.
#
# The gephi command launches a process that may never terminate in time. In my
# local test environment, it terminates in about 20 seconds. In the GitHub
# Actions runner, the build job fails because the runner exceeds the maximum
# execution time of 360 minutes [1].
#
# Thanks to Scott on Super User for a solution that terminates immediately after
# finding the right output. [2]. It uses command grouping syntax [3] to stop
# Gephi as soon as the version is printed. The grep output continues downstream
# and the pkill command produces no output.
#
# The gephi command launches two new processes with very long command lines that
# each contain the word "gephi" somewhere.
#
# In the local test environment pid 1 may also contain the word "gephi", so
# limit the search to children of this script's process.
#
# [1]: https://github.com/iainelder/dotfiles/actions/runs/2988076611
# [2]: https://superuser.com/questions/1450928/how-to-kill-a-pipeline-once-some-output-has-occurred
# [3]: https://www.gnu.org/software/bash/manual/html_node/Command-Grouping.html
gephi --modules --list \
| {
    grep --max-count 1 org.gephi.welcome.screen; \
    pkill --parent $$ --oldest --full gephi;
  } \
| awk '{print $2}'
