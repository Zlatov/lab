#!/usr/bin/env bash

set -eu

. ../array.sh

function passed {
  echo "passed"
}

function failed {
  echo "failed"
}

a=(asd zxc qwe)
a[11]=111 # a+=(111)

is_included blaha "${a[@]}" && failed || passed
is_included zxc "${a[@]}" && passed || failed

[[ $(get_index asd "${a[@]}") == "0" ]] && passed || failed
[[ $(get_index zxc "${a[@]}") == "1" ]] && passed || failed
[[ $(get_index qwe "${a[@]}") == "2" ]] && passed || failed
[[ $(get_index 111 "${a[@]}") == "3" ]] && passed || failed
