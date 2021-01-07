#!/usr/bin/env bats

load 'bats-assert/load'
load 'bats-support/load'

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

@test "aws-sam-cli is installed" {
  sam --version
}

@test "jccli is installed" {
  jccli --version
}

@test "cfn-lint is installed" {
  cfn-lint --version
}

# Latest working version of Taskcat
# See https://github.com/aws-quickstart/taskcat/issues/602
@test "taskcat version 0.9.13 is installed" {
  run taskcat --version
  assert_output --partial "version 0.9.13"
}

@test "docker is installed" {
  docker --version
}

@test "scrcpy is installed" {
  scrcpy --version
}

@test "yamllint is installed" {
  yamllint --version
}

@test "yq is installed" {
  yq --version
}
