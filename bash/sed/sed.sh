#!/bin/bash
echo день | sed s/день/ночь/
echo '.PNG' | sed s/'.PNG'/'.png'/

echo 'asd.PNG' | sed s/'.PNG'/'.png'/

echo '.PNG.PNG' | sed 's/\.PNG$/.png/'

