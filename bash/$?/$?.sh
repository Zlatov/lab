#!/usr/bin/env bash

set -eu

echo '$BASHPID 1: ' $BASHPID

(
  echo '$BASHPID 2: ' "${BASHPID-}"
  ls ttt
  ls ./
  echo "Done. =================================="
) && (
  echo "Команды подпроцесса выполнены нормально."
  echo '$BASHPID 3: ' $BASHPID
)

a="a1"
echo '$a: ' $a
{
  echo "Этот же процесс что и родительский."
  echo "block ${BASHPID}"
  echo '$a: ' $a
  ls ttt
} && {
  echo 'предыдущая команда выполнена корректно $?: ' $?
} || {
  echo 'предыдущая команда выполнена не корректно $?: ' $?
}
echo '$?: ' $?
echo '$a: ' $a

echo hi
