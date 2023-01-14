exit 0

# Установить
git tag  # — список существующих tag-ов
git tag -m "описание" tagname  # — создать метку tag для текущего состояния (на текущей ветке) с именем tagname.

# Отправить
git push origin tag_name  # — To push a single tag
git push --tags  # — push all tags (not recommended)

# Получить
git fetch --tags  # — fetch tags.

# Удалить все локальные тэги и получить с ориджин
git tag -l | xargs git tag -d
git fetch --tags

# Удалить
git tag -d tagname  # — удалить метку tag с именем tagname
git push --delete origin 12345  # — запушить удаление тега.

# Изменить описание (сообщение) к старому тегу и отправить в репозиторий:
git tag 0.3.0 0.3.0^{} -f -a # откроет тектовый редактор для изменения сообщения
git push --tags # должно запретить: ! [rejected] 0.3.0 -> 0.3.0 (already exists)
git push --delete origin 0.3.0 # удалит в оригинальном репозитории тег: - [deleted] 0.3.0
git push --tags # * [new tag] 0.3.0 -> 0.3.0
