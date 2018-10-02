#!/usr/bin/env bash
exit 0

# Динамически
function app_complete {
  current_word="${COMP_WORDS[COMP_CWORD]}"
  completions=$(app complete "${COMP_WORDS[@]}" "${COMP_CWORD}")
  COMPREPLY=( $(compgen -W "${completions}" -- ${current_word}) )
}
complete -F app_complete app
# 
# Где
# 
# COMPREPLY - массив, из которого bash получает _возможные_ дополнения.
# COMP_WORDS - массив, содержащий уже введённые аргументы.
# COMP_CWORD - индекс в массиве COMP_WORDS, редактируемого аргумента в данный момент.
# compgen - встроенная утилита bash, преобразующая список всех возможных
#   значений аргумента в значения, до которых можно дополнить введенную часть.
# 

# Разово
complete -W "$(app complete)" app

# Ну и самое главное — подключение нашего скрипта к башу на постоянной основе.
# Это делается либо (топорно) прописыванием вызова нашего скрипта в .bashrc,
# либо (стандартно, если у вас есть такой файл: ) через /etc/bash_completion.
# Во втором случае мы должны положить наш скрипт в /etc/bash_completion.d,
# все скрипты откуда подцепляются из /etc/bash_completion.
