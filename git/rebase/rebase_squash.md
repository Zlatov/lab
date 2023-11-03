# Объединение старых коммитов rebase/squash

```sh
# Список комитов
git log --oneline
git log --pretty=format:'%h%x09%an%x09%ad%x09%s' --date=format:'%Y-%m-%d %H:%M:%S'
git log --pretty=format:'%h %an %ad %s' --date=short
# %h = abbreviated commit hash
# %x09 = tab (character for code 9)
# %an = author name
# %ad = author date (format respects --date= option)
# %s = subject

# Преключиться на коммит ДО коммита в который сливаем и ДО коммитов которые сливаем.
git rebase -i d99ac7d

# Первый комит оставляем pick, последующие помечаем squash (объединить с предыдущим коммитом). Сохраняем файл.
pick a869b4c red header
squash 0c9766c style file
pick 5ebd7e9 task

# Редактируем новое коммит-сообщение. Сохраняем файл.
red header

# Отправляем изменение истории
git push --force

# Если сохранили пустое коммит сообщение - отменяется слияние, но репозиторий находится в состоянии смещения, отменить смещение:
git rebase --abort
```
