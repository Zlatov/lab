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


filename="document.txt"

if [[ "$filename" =~ \.txt$ ]]; then
  echo "Filename has a .txt extension"
else
  echo "Filename does not have a .txt extension"
fi

comment="add: asdsadasda; :noautodeploy"
comment="add: asdsadasda;"

if [[ ! "$comment" =~ :noautodeploy ]]; then
  echo "deploy"
else
  echo "no"
fi

[[ ! "$comment" =~ :noautodeploy ]] && echo deploy || echo no
