#!/bin/bash

STRING="100.1.1"
ARRAY=(${STRING//./})
A=100
B=2
if [[ $A -gt $B ]] && [[ ${ARRAY[0]} -gt 2 ]]
	then
		echo "1"
	else
		echo "2"
fi


# C=2
if [[ $C -ne 1 ]]
then
	echo "C not 1"
else
	echo "C 1"
fi
