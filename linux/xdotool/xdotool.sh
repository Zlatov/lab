#!/bin/bash


# pids=$(xdotool search --class --onlyvisible "subl")
# for pid in $pids; do
#     name=$(xdotool getwindowname $pid)
#     if [[ $name == *" Sublime Text"* ]]; then
#         start=`expr index "$name" '\('`
#         finish=`expr index "$name" '\)'`
#         let "len=finish-start-1"
#         newTitle=${name:start:len}
#         xdotool set_window --name "$newTitle" "$pid"
#     fi
# done


# sleep .1 &&
# xdotool key Ctrl+0 &&
# sleep .1 &&
# xdotool key Home &&
# sleep .5 &&
# xdotool mousemove 16 80 &&
# sleep .05 &&
# xdotool keydown Alt+Ctrl click 1 &&
# xdotool keyup Alt+Ctrl &&
# sleep 1 &&
# xdotool click 1
