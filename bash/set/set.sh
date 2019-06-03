#!/usr/bin/env bash

# 
# При использовании нижеследующей комбинации команд:
# set -a
# . ./var.sh
# set +a
# Произойдёт экспорт переменных назначаемых между set-ами (`B='BBB'`).
# Это означает, что данные переменные будут доступны не только в текущем скрипте, но и
# в скриатах-командах, например `./command.sh`, то-есть попадут в переменные окружения.
# 

echo "---"
echo "In start env:"
echo '$A: ' $A
echo '$B: ' $B
echo '$DEVELOPER_HOST: ' $DEVELOPER_HOST
echo '$HOME: ' $HOME
echo ~

env -i ./command_clean_env.sh
