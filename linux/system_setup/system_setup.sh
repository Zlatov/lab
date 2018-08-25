#!/usr/bin/env bash

# 
# cd ~ && mkdir -p projects/my/lab
# git clone git@github.com:Zlatov/lab.git projects/my/lab
# sudo projects/my/lab/linux/system_setup/system_setup.sh
# 

set -eu

cd ~

lab_path=projects/my/lab
. $lab_path/bash/_lib/echoc

if hash yarn 2>/dev/null
then
  echoc 'yarn уже установлен.' blue
else
  echoc 'Установка yarn.' yellow
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
  sudo apt-get update && sudo apt-get install yarn
  echoc 'Yarn установлен.' green
fi

git config --global core.excludesfile ~/.gitexcludes
