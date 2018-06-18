#!/usr/bin/env bash
# !/bin/bash
# set -eu

cd `dirname $0`

if [[ ! -f temp ]]
then
  touch temp
fi

> temp


echo $HOME >> temp

source "$HOME/.bash_profile"

time=$(date '+%Y-%m-%d %H:%M:%S')
echo $time >> temp

echo $HOME >> temp
echo $PG_USER >> temp

echo $time >> temp



# echo $HOME

# source "$HOME/.bash_profile"

# time=$(date '+%Y-%m-%d %H:%M:%S')
# echo $time

# echo $HOME
# echo $PG_USER

# echo $time
