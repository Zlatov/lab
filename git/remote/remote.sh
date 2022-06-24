exit 0

git remote -v # Показать хранилища и их url-ы

# Изменить урл хранилища (без удаления)
git remote set-url origin https://github.com/USERNAME/REPOSITORY.git

# Или
git remote remove old-origin
git remote add origin <url>

# Перенос в другой гит репозиторий
git remote rename origin old-origin
git remote add origin git@gitlab.newstar.ru:gitlab-instance-2d4cb74e/zenonline-admin.git
git push -u origin --all
git push -u origin --tags

# Сменить какую удалённую ветку отслеживает локальная
git branch --set-upstream-to=origin/master master
