#!/usr/bin/env bash
set -eu

exit 0

# Добавить рабочую ветку
git worktree add ../folder name-of-branch

# Посмотреть список рабочих деревьев
git worktree list

# Когда все изменения сделаны и отправлены на сервер можно просто удалить эту папку, а затем выполнить команду которая всё подчистит.
git worktree prune
