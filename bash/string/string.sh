#!/bin/bash
I="foobar"

# Замена
a="foobarfoofoo"
b=${a/oo/aa}
echo $a
echo $b

echo ${I:1:2}   #substring
# -> oo
echo ${I%bar}   #trailing substitution
# -> foo
echo ${I#foo}   #leading substitution
# -> bar