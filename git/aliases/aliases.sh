#!/usr/bin/env bash

set -eu

exit 0

# subl ~/.bashrc
echo "alias  s='git status -u'"            | tee -a ~/.bashrc >/dev/null
echo "alias  a='git add'"                  | tee -a ~/.bashrc >/dev/null
echo "alias aa='git add -A'"               | tee -a ~/.bashrc >/dev/null
echo "alias  r='git reset HEAD'"           | tee -a ~/.bashrc >/dev/null
echo "alias  c='git commit'"               | tee -a ~/.bashrc >/dev/null
echo "alias ca='git add -A && git commit'" | tee -a ~/.bashrc >/dev/null

git config --global alias.hist 'log --pretty=format:"%h %ad | %s%d [%an]" --graph --date=short'
git config --global alias.hist 'log --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit'
