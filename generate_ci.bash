#!/bin/bash

set -euxo pipefail
set +x

template=".github/workflows/_program.yml.template"

for program in scripts/programs/*.bash; do

  file_basename="$(basename "${program}" .bash)"

  set +e
  program_name="$(grep --perl-regexp --only-matching '(?<=# Name: ).*$' "${program}")"
  set -e

  # shellcheck disable=SC2002
  cat "${template}" |
  program_name="${program_name:-$file_basename}" \
  program_script="${program}" \
  envsubst \
  > .github/workflows/"${file_basename}.yml"

done
