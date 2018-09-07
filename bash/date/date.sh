#!/bin/bash

. ../_lib/echoc

echoc 'Просто date в текущей зоне и UTC' green
date
date -u

echoc 'Привычные форматы' green
date +%Y-%m-%d
date '+%Y-%m-%d %H:%M:%S %:z'
date +%s
date -u +%s # равно date +%s, так как %s есть UNIX время (с 00:00:00 1970-01-01 UTC)

echoc 'Наносекунды' green
date +%N
