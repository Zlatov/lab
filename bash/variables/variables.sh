#!/bin/bash

test() {
  local lvar="Local content"
  echo "Local variable value with in the function"
  # echo $lvar
  echo '$lvar: ' $lvar
  gvar="Global content changed"
  echo -e "Global variable value with in the function"
  # echo $gvar
  echo '$gvar: ' $gvar
}

gvar="Global content"
echo -e "Global variable value before calling function"
# echo $gvar
echo '$gvar: ' $gvar
echo -e "Local variable value before calling function"
# echo $lvar
echo '$lvar: ' $lvar
test
echo -e "Global variable value after calling function"
# echo $gvar
echo '$gvar: ' $gvar
echo -e "Local variable value after calling function"
# echo $lvar
echo '$lvar: ' $lvar
