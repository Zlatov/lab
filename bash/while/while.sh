#!/usr/bin/env bash

set -eu

a=9
while (( $a > 0 ))
do
  echo -n $a
  (( a-- ))
done

echo $a
