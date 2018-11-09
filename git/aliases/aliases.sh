#!/usr/bin/env bash

set -eu

exit 0

subl ~/.bashrc
echo "alias gca='git add -A && git commit'" | tee -a ~/.bashrc >/dev/null

git config --global alias.hist 'log --pretty=format:"%h %ad | %s%d [%an]" --graph --date=short'
git config --global alias.hist 'log --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit'
