#!/bin/bash
. ../_lib/echoc

echoc 'Передадим все аргументы команде' green
echo A B C | xargs echo

echoc 'Передадим по 2 аргумента команде' green
echo A B C | xargs -n2 echo
#                  ├─┘
#                  └ максимально возможное количество аргументов

echoc 'Вся строка как один аргумент' green
cat lines.txt | xargs -I {} echo {}
#                     ├┘ ├┘
#                     │  └ строка подстановки аргумента
#                     │
#                     └ выполняется для каждой строки, причём вся строка рассматривается как один аргумент

# cd ../
# ls ./xargs/* | xargs -I FILE echo "cp FILE FILE" | sed s/\.sh$/.SH/ | xargs -I CP sh -c "CP"
# ls ./*/main_image/thumbnail_*.PNG | xargs -I FILE echo "cp FILE FILE" | sed s/\.PNG$/.png/ | xargs -I CP sh -c "CP"

echoc 'Параллельность запускаемой команды:' red
seq 15 | xargs --max-procs=4 -n2 echo

# проверьте, как веб-сервер страдает от нагрузки
# -P50 - 50 процессов одновременно
# seq 1000 | xargs -P50 -I NONE lwp-request http://localhost:3000/
seq 15 | xargs -P50 -I NONE echo NONE

seq 1 | xargs -P50 -I NONE ./subproc.sh
echo 'sps'
