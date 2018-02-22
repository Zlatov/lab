#!/bin/bash

# Замена
a="foobarfoofoo"
b=${a/oo/aa}
echo $a
echo $b

a='0'
aa='0'
echo "a${a}aa"

I="foobar"
echo ${I:1:2}   #substring
# -> oo
echo ${I%bar}   #trailing substitution
# -> foo
echo ${I#foo}   #leading substitution
# -> bar