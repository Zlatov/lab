#!/usr/bin/env bash

. ../_lib/echoc

# lsof -i -P -n | grep LISTEN 
# netstat -tulpn | grep LISTEN
# nmap -sTU -O IP-address-Here

function is_port_busy {
  local count=$(lsof -i -P -n | grep -c ":${1}")
  [[ "$count" -gt 0 ]] && return 0
  return 1
}

function echo_is_port_busy {
  if is_port_busy $1
  then
    echo -n ' '; echoc -n "$1" red # busy
  else
    echo -n ' '; echoc -n "$1" green # free
  fi
}

# echo_is_port_busy 3100
# echo_is_port_busy 3101

for (( i = 0; i < 1000; i++ )); do
  echo_is_port_busy $i
done