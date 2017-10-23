#!/bin/bash
string='/2.4 . (9ab) - Sublime Text (UNREGISTRED)'
start=`expr index "$string" '\('`
echo $start

string='My string';
 
if [[ "$string" == *My* ]]
then
  echo "It's there!";
fi
 
needle='y s'
if [[ "$string" == *"$needle"* ]]; then
  echo "haystack '$string' contains needle '$needle'"
fi