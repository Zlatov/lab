exit 0

git tag  # — список существующих tag-ов
git tag -m "описание" tagname  # — создать метку tag для текущего состояния (на текущей ветке) с именем tagname.
git tag -d tagname  # — удалить метку tag с именем tagname
git push origin tag_name  # — To push a single tag
git push --tags  # — push all tags (not recommended)
git fetch --tags  # — fetch tags.
git tag -d 12345  # — удалить тег.
git push --delete origin 12345  # — запушить удаление тега.
