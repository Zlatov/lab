#!/bin/bash
declare -A a

a=(['a']='a' ['b']=0)

echo ${a[@]}
echo ${a[a]}
echo ${a[b]}
echo ${#a[*]}
