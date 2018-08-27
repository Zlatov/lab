#!/usr/bin/env bash
set -eu

cd ~
lab_path=projects/my/lab
. $lab_path/bash/_lib/echoc

if [[ -f ~/.bashrc-iadfeshchm && -f ~/.bashrc ]] && egrep -q "^\[\[ -s ~/.bashrc-iadfeshchm \]\] && source ~/.bashrc-iadfeshchm" ~/.bashrc
then
  echoc "Уже настроен .bashrc." blue
else
  cp ~/$lab_path/linux/system_setup/system_setup/bashrc/.bashrc-iadfeshchm ~/
  echo "[[ -s ~/.bashrc-iadfeshchm ]] && source ~/.bashrc-iadfeshchm" >> ~/.bashrc
  echoc "Настроен .bashrc." green
fi
