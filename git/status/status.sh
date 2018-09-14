#!/usr/bin/env bash
. ../../bash/_lib/echoc

# 
# Состояния
# 
# untracked
# unmodified
# modified
# staged
# 

code=$(git status --porcelain) # Объеденяет все последующие три когманды

code=$(git diff --exit-code) # modified, modified-deleted
code=$(git diff --cached --exit-code) # untracked-staged, modified-staged, deleted-staged
code=$(git ls-files --other --exclude-standard --directory) # untracked
code=$(git ls-files --other --exclude-standard) # untracked

[[ -n "$(git diff --exit-code)" ]] && echo is_has_modified
[[ -n "$(git diff --cached --exit-code)" ]] && echo is_has_staged
[[ -n "$(git ls-files --other --exclude-standard --directory)" ]] && echo is_has_untracked
