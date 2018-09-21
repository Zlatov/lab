exit 0

# Установить
git tag  # — список существующих tag-ов
git tag -m "описание" tagname  # — создать метку tag для текущего состояния (на текущей ветке) с именем tagname.

# Отправить
git push origin tag_name  # — To push a single tag
git push --tags  # — push all tags (not recommended)

# Получить
git fetch --tags  # — fetch tags.

# Удалить
git tag -d tagname  # — удалить метку tag с именем tagname
git push --delete origin 12345  # — запушить удаление тега.
