#!/usr/bin/env bash
. ../_lib/echoc


function check_temp {
  if [[ -d temp ]]
  then
    echoc "Папака temp существует." green
  else
    echoc "Папака temp не существует." red
  fi
}

check_temp

if [[ ! condition ]]; then
  #statements
fi
