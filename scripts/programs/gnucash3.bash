#!/bin/bash

# Name: GnuCash 3

set -euxo pipefail

cd "$(mktemp --dir)"

sudo apt-get update && sudo apt-get install --yes \
gnucash

# My desktop language is Spanish, but I use the English localization.
# Financial language is hard enough to understand without mangled
# translations such as "Puede escoger un conjunto de ficheros aquí que
# parece cerrar a sus necesidades".
# - "seems close to"? - "aproxime"?
sudo sed \
--in-place=.bak \
--expression 's%^Exec=\(.*\)$%Exec=/bin/bash -c "LANGUAGE=en_GB \1"%' \
/usr/share/applications/gnucash.desktop
