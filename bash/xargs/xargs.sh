#!/bin/bash
ls | xargs -I SOME echo SOME
cd ../
ls ./xargs/* | xargs -I FILE echo "cp FILE FILE" | sed s/\.sh$/.SH/ | xargs -I CP sh -c "CP"

# ls ./*/main_image/thumbnail_*.PNG | xargs -I FILE echo "cp FILE FILE" | sed s/\.PNG$/.png/ | xargs -I CP sh -c "CP"
