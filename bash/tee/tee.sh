#!/usr/bin/env bash
set -eu

touch temp && > temp
touch temp_append && > temp

echo asd | tee temp >/dev/null
echo asd | tee temp >/dev/null

echo zxc | tee -a temp_append >/dev/null
echo zxc | tee -a temp_append >/dev/null
