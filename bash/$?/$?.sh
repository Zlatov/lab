#!/usr/bin/env bash

set -eu 

echo $BASHPID

(
  echo "sub ${BASHPID}"
  # ls ttt
  ls ./
) && (
  echo hi1
)

a="a1"
echo '$a: ' $a
{
  echo "block ${BASHPID}"
  echo '$a: ' $a
  ls ttt
} && {
  echo '$?: ' $?
} || {
  echo '$?: ' $?
}
echo '$?: ' $?
echo '$a: ' $a

echo hi
