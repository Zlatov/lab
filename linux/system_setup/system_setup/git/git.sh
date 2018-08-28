#!/usr/bin/env bash
set -eu

cd ~
lab_path=projects/my/lab
. $lab_path/bash/_lib/echoc

if [[ ! $(git config --global core.excludesfile) = "" && -f ~/.gitexcludes ]]
then
  echoc "Уже настроен git gitexcludes." blue
else
  cp $lab_path/linux/system_setup/system_setup/git/.gitexcludes ~/.gitexcludes
  git config --global core.excludesfile ~/.gitexcludes
  echoc "Настроен git gitexcludes." green
fi
