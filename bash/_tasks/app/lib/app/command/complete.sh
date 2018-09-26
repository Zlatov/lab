function app_complete {
  # local cur prev opts
  # # COMP_WORDS — все отдельные слова в текущей командной строке.
  # # COMP_CWORD — является индексом слова, содержащего текущую позицию курсора.
  # # COMPREPLY — представляет собой переменную массива, из которой Bash считывает возможные доработки.
  # COMPREPLY=()
  # cur="${COMP_WORDS[COMP_CWORD]}"
  # prev="${COMP_WORDS[COMP_CWORD-1]}"
  # opts="asd zxc"
  # # if [[ ${cur} == -* ]]
  # # then
  # #   COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
  # #   return 0
  # # fi
  # COMPREPLY=( $(compgen -W "${_script_commands}" -- ${cur}) )
  # return 0
  echo '\
    deploy rollback test complete pull man\
    admin market framework
  '
}
