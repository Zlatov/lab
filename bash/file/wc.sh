#!/bin/bash

. ../_lib/echoc

if [[ ! -f temp ]]
then
	touch temp
fi

echo -n 'a' > temp
# echo 'b' >> temp

a=$(wc -l < temp)
echoc "количество строк (скорее переносов) в файле: ${a}." blue
