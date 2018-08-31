#!/usr/bin/env bash

function is_included {
  local element wanted="$1"
  shift
  for element
  do
    [[ "$element" == "$wanted" ]] && return 0
  done
  return 1
}

# a=(asd zxc qwe)
# if is_included blaha "${a[@]}"; then echo y; else echo n; fi
# if is_included zxc "${a[@]}"; then echo y; else echo n; fi
