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
  echo "Этот же процесс что и родительский."
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
