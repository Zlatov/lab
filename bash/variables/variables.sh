#!/bin/bash

test() {
  local lvar="Local content"
  echo '$lvar: ' $lvar
  gvar="Global content changed"
  echo '$gvar: ' $gvar
}

gvar="Global content"
echo '$gvar: ' $gvar
echo '$lvar: ' $lvar

echo '----------------------'

test

echo '----------------------'

echo '$gvar: ' $gvar
echo '$lvar: ' $lvar
