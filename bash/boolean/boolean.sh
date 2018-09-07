#!/usr/bin/env bash

. ../_lib/echoc

bool=true

if [ "$bool" = true ]; then
if [ "$bool" = "true" ]; then

if [[ "$bool" = true ]]; then
if [[ "$bool" = "true" ]]; then
if [[ "$bool" == true ]]; then
if [[ "$bool" == "true" ]]; then

if test "$bool" = true; then
if test "$bool" = "true"; then
echoc "TRUE" green
fi
fi
fi
fi
fi
fi
fi
fi


a=true
b=false

# single variable
echo
echoc "single variable" green
if [[ "$a" = true ]]; then echo true; fi
if [[ ! "$b" = true ]]; then echo true; fi

# &&
echo
echoc "&&" green
if [[ "$a" = true && "$a" = true ]]; then echo true; fi
if [[ ! ( "$a" = true && "$b" = true ) ]]; then echo true; fi
if [[ ! ( "$b" = true && "$a" = true ) ]]; then echo true; fi
if [[ ! ( "$b" = true && "$b" = true ) ]]; then echo true; fi

# ||
echo
echoc "||" green
if [[ "$a" = true || "$a" = true ]]; then echo true; fi
if [[ "$a" = true || "$b" = true ]]; then echo true; fi
if [[ "$b" = true || "$a" = true ]]; then echo true; fi
if [[ ! ( "$b" = true || "$b" = true ) ]]; then echo true; fi
