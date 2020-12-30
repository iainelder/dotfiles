#!/usr/bin/env bats

@test "curl is installed" {
  result="curl --version"
  [ "$?" -eq 0 ]
}

@test "User tmp dir exists" {
  [ -d ~/tmp ]
}

@test "jq is installed" {
  result="jq --version"
  [ "$?" -eq 0 ]
}

@test "pip3 is installed" {
  result="$(pip3 --version)"
  [ "$?" -eq 0 ]
}

@test "pipx is installed" {
  result="$(pipx --version)"
  [ "$?" -eq 0 ]
}

@test "csvkit is installed" {
  in2csv --version
  [ $? -eq 0 ]
}
