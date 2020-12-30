#!/usr/bin/env bats

@test "pip3 is installed" {
  result="$(pip3 --version)"
  [ "$?" -eq 0 ]
}

@test "pipx is installed" {
  result="$(pipx --version)"
  [ "$?" -eq 0 ]
}

