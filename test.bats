#!/usr/bin/env bats

@test "pipx is installed" {
  result="$(pipx --version)"
  [ "$?" -eq 0 ]
}

