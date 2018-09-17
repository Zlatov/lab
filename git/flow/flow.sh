#!/usr/bin/env bash
exit 0

# Установка
apt-get install git-flow
git flow init

# Фичи
git flow feature start MYFEATURE # Это действие создаёт новую ветку фичи, основанную на ветке "develop", и переключается на неё.
git flow feature finish MYFEATURE # Слияние ветки MYFEATURE в "develop". Удаление ветки фичи. Переключение обратно на ветку "develop"
git flow feature publish MYFEATURE # Опубликуйте фичу на удалённом сервере, чтобы её могли использовать другие пользователи.
git flow feature pull origin MYFEATURE # Получение фичи, опубликованной другим пользователем.
git flow feature track MYFEATURE # отслеживать фичу в репозитории origin

# Релизы
git flow release # Она создаёт ветку релиза, ответляя от ветки "develop".
git flow release start RELEASE [BASE] # При желании вы можете указать [BASE]-коммит в виде его хеша sha-1, чтобы начать релиз с него.
git flow release publish RELEASE # Желательно сразу публиковать ветку релиза после создания, чтобы позволить другим разработчиками выполнять коммиты в ветку релиза.
git flow release track RELEASE # Вы также можете отслеживать удалённый релиз

git flow release finish RELEASE # Ветка релиза сливается в ветку "master". Релиз помечается тегом равным его имени. Ветка релиза сливается обратно в ветку "develop". Ветка релиза удаляется.
git push --tags # отправить изменения в тегах

# Хотфиксы
git flow hotfix start VERSION [BASENAME] # работа над исправлением. При желании можно указать BASENAME-коммит, от которого произойдёт ответвление.
git flow hotfix finish VERSION # Когда исправление готово, оно сливается обратно в ветки "develop" и "master". Кроме того, коммит в ветке "master" помечается тегом с версией исправления.
