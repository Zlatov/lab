#!/bin/bash

xdg-open https://google.com

# Или

URL='https://google.com'
if which xdg-open > /dev/null
then
  xdg-open URL
elif which gnome-open > /dev/null
then
  gnome-open URL
fi
