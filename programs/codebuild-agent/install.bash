#!/bin/bash

# Name: AWS CodeBuild agent
# Source: https://docs.aws.amazon.com/codebuild/latest/userguide/use-codebuild-agent.html

set -euxo pipefail

cd "$(mktemp --dir)"

sudo apt-get install --yes \
git

repo_url="https://github.com/aws/aws-codebuild-docker-images.git"
local_path="/opt/aws-codebuild-docker-images"

if ! test -d "${local_path}"; then
  sudo git clone "${repo_url}" "${local_path}"
else
  sudo git -C "${local_path}" pull
fi

sudo ln -sf "${local_path}"/local_builds/codebuild_build.sh /usr/local/bin/codebuild_build.sh

codebuild_build.sh -h
