#!/bin/bash
set -eu

echo 'Список экранов.'
# screen -list | grep '('

echo 'Проверка экрана с именем temp.'
if screen -list | grep -q 'temp'
then
    echo 'Экран существует.'
else
    echo 'Экран не существует.'
    echo 'Создаём экран.'
	screen -dmS temp
	echo 'Экран temp создан.'
fi

echo 'Проверка экрана с именем temp2.'
if screen -list | grep -q 'temp2'
then
    echo 'Экран существует.'
else
    echo 'Экран не существует.'
    echo 'Создаём экран.'
	screen -dmS temp2
	echo 'Экран temp2 создан.'
fi

echo 'Проверка экрана с именем temp.'
if (( `screen -list | grep -c 'temp'` >= 2))
then
    echo 'Экранов с таким именем много.'
    screen_id=$(screen -list | grep temp | head -n 1 | sed -nr 's/(.*[0-9]+.[a-zA-Z_]+).*/\1/p')
    if [[ ! "$screen_id" = '' ]]
    then
    	echo 'Определён идентификатор экрана, удаляем экран.'
    	screen -S $screen_id -X quit
    else
    	echo 'Не удалось определить идентификатор экрана.'
    fi
elif (( `screen -list | grep -c 'temp'` == 1))
then
    echo 'Экран существует.'
    echo 'Удаляем экран.'
    screen -S 'temp' -X quit
    echo 'Экран удалён.'
else
    echo 'Экран не существует.'
fi

echo 'Список экранов.'
# screen -list | grep '('

# Если вы хотите убить: screen -S name -X quit
# Если вы хотите отсоединить: screen -dS name
# 1) send a 'quit' command:
# screen -X -S "sessionname" quit
# 2) send a Ctrl-C to a screen session running a script:
# screen -X -S "sessionname" stuff "^C"


# screen -S bilbo -X exec vim /some/file

# работает
# screen -S temp -X register c $"echo 'hi'\n"
# screen -S temp -X paste c

# работает
# screen -S temp -p 0 -X stuff "echo 'hu'"
# screen -S temp -p 0 -X eval "stuff ^M"