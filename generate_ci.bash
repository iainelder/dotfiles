#!/bin/bash

set -euo pipefail

template=".github/workflows/_program.yml.template"

for program in programs/**/install.bash; do

  echo "Generating CI for ${program}"

  workflow_filename="$(basename "$(dirname "${program}")")"

  set +e
  program_name="$(grep --perl-regexp --only-matching '(?<=# Name: ).*$' "${program}")"
  set -e

  # shellcheck disable=SC2002
  cat "${template}" |
  program_name="${program_name:-$workflow_filename}" \
  program_script="${program}" \
  envsubst \
  > .github/workflows/"${workflow_filename}.yml"

done
