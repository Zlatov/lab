#!/bin/bash
exit 0

git log # - история фиксаций от начала до текущего состояния HEAD.
git log branchNameOrCommitHash # - от начала до указанной ветви или фиксации.
git log branchNameOrCommitHash..branchNameOrCommitHash # - история указанного диапазона.
git log branchName...branchName # - общая история указанного диапазона (по всем веткам).
git log FETCH_HEAD # - от начала до состояний FETCH_HEAD (состояние FETCH_HEAD доступно после операции fetch или pull).
git log HEAD..FETCH_HEAD # - от места совпадения HEAD и FETCH_HEAD, и до конца истории.
git log HEAD...FETCH_HEAD # - общая историю от места совпадения HEAD и FETCH_HEAD, и до конца истории.

# Алиасы для log
git config --global alias.hist 'log --pretty=format:"%h %ad | %s%d [%an]" --graph --date=short'
git config --global alias.hist 'log --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit'
