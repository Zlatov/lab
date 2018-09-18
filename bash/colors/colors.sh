#!/usr/bin/env bash

# Три способа эскейпа форматирования:
# \e
# \033
# \x1B
echo -e "\e[31m asd \e[0m"
echo -e "\033[31m asd \033[0m"
echo -e "\x1B[31m asd \x1B[0m"

# Установка нового формата
echo -e "1 Жирным        \e[1m asd \e[0m"
echo -e "2 Тонко         \e[2m asd \e[0m"
echo -e "4 Подчёркнуто   \e[4m asd \e[0m"
echo -e "5 Моргающего    \e[5m asd \e[0m"
echo -e "7 Инвертировано \e[7m asd \e[0m"
echo -e "8 Скрыто        \e[8m asd \e[0m"

# Сброс форматов
echo -e "0  Сброс Всех форматов  \e[0m asd \e[0m asd"
echo -e "21 Сброс Жирного        \e[1m asd \e[21m asd"
echo -e "22 Сброс Тонкого        \e[2m asd \e[22m asd"
echo -e "24 Сброс Подчёркнутого  \e[4m asd \e[24m asd"
echo -e "25 Сброс Моргающего     \e[5m asd \e[25m asd"
echo -e "27 Сброс Инвертированого\e[7m asd \e[27m asd"
echo -e "28 Сброс Скрытого       \e[8m asd \e[28m asd"

for i in {16..21} {21..16} ; do echo -en "\e[38;5;${i}m#\e[0m" ; done ; echo

echo -e "\e[39m asd \e[0m — 39 default"
echo -e "\e[30m asd \e[0m — 30 black"
echo -e "\e[31m asd \e[0m — 31 red"
echo -e "\e[32m asd \e[0m — 32 green"
echo -e "\e[33m asd \e[0m — 33 yellow"
echo -e "\e[34m asd \e[0m — 34 blue"
echo -e "\e[35m asd \e[0m — 35 magenta"
echo -e "\e[36m asd \e[0m — 36 cyan"
echo -e "\e[37m asd \e[0m — 37 light gray"
echo -e "\e[90m asd \e[0m — 90 dark gray"
echo -e "\e[91m asd \e[0m — 91 light red"
echo -e "\e[92m asd \e[0m — 92 light green"
echo -e "\e[93m asd \e[0m — 93 light yellow"
echo -e "\e[94m asd \e[0m — 94 light blue"
echo -e "\e[95m asd \e[0m — 95 light magenta"
echo -e "\e[96m asd \e[0m — 96 light cyan"
echo -e "\e[97m asd \e[0m — 97 white"
