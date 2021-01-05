#!/usr/bin/env bats

@test "curl is installed" {
  result="curl --version"
  [ "$?" -eq 0 ]
}

@test "git is installed" {
  result="git --version"
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

@test "aws-cli version 2 is installed" {
  run aws --version
  assert_output --regexp '^aws-cli/2'
}
