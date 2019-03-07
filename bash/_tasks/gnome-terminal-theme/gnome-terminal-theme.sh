#!/usr/bin/env bash

set -eu

cd "$(dirname "${0}")"

. ../../_lib/echoc

THEME_DARK="['rgb(7,54,66)', 'rgb(220,50,47)', 'rgb(133,153,0)', 'rgb(181,137,0)', 'rgb(38,139,210)', 'rgb(211,54,130)', 'rgb(42,161,152)', 'rgb(238,232,213)', 'rgb(0,43,54)', 'rgb(203,75,22)', 'rgb(88,110,117)', 'rgb(101,123,131)', 'rgb(131,148,150)', 'rgb(108,113,196)', 'rgb(147,161,161)', 'rgb(253,246,227)']"
THEME_DEFAULT="['rgb(46,52,54)', 'rgb(204,0,0)', 'rgb(78,154,6)', 'rgb(196,160,0)', 'rgb(52,101,164)', 'rgb(117,80,123)', 'rgb(6,152,154)', 'rgb(211,215,207)', 'rgb(85,87,83)', 'rgb(239,41,41)', 'rgb(138,226,52)', 'rgb(252,233,79)', 'rgb(114,159,207)', 'rgb(173,127,168)', 'rgb(52,226,226)', 'rgb(238,238,236)']"

dconf list /org/gnome/terminal/legacy/profiles:/
array=($(dconf list /org/gnome/terminal/legacy/profiles:/))
# echo '$array: ' $array
for i in ${!array[@]}
do
  item=${array[$i]}
  echo "$i: $item"
  dconf read /org/gnome/terminal/legacy/profiles:/${item}palette
  dconf write /org/gnome/terminal/legacy/profiles:/${item}palette "${THEME_DARK}"
done

# 
# Или для текущего окна можно установить через stterm...
# 
