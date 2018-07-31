#!/bin/bash

# 
# -q  Немногословный режим. В стандартный выходной поток не выдается ничего,
#     кроме сопоставившихся строк. Если одна из входных строк соответствует
#     образцу, возвращается статус выхода 0.
# 

ls -la ./ | grep 'grep'
ls -la ./ | grep -q 'grep'
if ls -la ./ | grep -q 'grep'
then
  echo 'grep'
fi
if ls -la ./ | grep -q 'grepp'
then
  echo 'grepp'
else
  echo 'no grepp'
fi
