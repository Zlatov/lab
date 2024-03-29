#!/usr/bin/env bash

set -eu

# 
# Официально свободный пул портов (https://ru.wikipedia.org/wiki/Список_портов_TCP_и_UDP)
# 
# 48654—48999 свободны  Официально
# 49001—49150 свободны  Официально
# 

[[ $(sudo lsof -i -P -n | grep -c :52698) = '1' ]] && echo 'Порт занят.' || echo 'Порт свободен.'
sudo lsof -i -P -n | grep :9000
sudo netstat -pnat | grep :9000
sudo lsof -i -P -n | grep LISTEN
sudo netstat -tulpn | grep LISTEN
sudo ss -tulpn | grep LISTEN
sudo lsof -i:22 ## see a specific port such as 22 ##
sudo nmap -sTU -O IP-address-Here


# Определить процесс и его PID занимающий порт:
lsof -wni tcp:3000

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

for (( i = 10; i < 81; i++ )); do
  echo_is_port_busy $i
done
echo

# Прослушиваемые кем-то порты:
lsof -i -P -n
