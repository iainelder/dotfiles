#!/bin/bash

set -euxo pipefail
set +x

cfg=".github/workflows/ci.cfg"
template=".github/workflows/_program.yml.template"

for cifile in $(crudini --get "${cfg}"); do
  cat "$template" |
  program_name="$(crudini --get "$cfg" "${cifile}" program_name)" \
  program_script="$(crudini --get "$cfg" "${cifile}" program_script)" \
  envsubst \
  > .github/workflows/"${cifile}"
done
