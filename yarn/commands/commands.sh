exit 0

yarn init # старт нового проекта.

# Добавить зависимости:
yarn add [package];
yarn add [package]@[version];
yarn add [package]@[tag].

# Указать категорию зависимостей devDependencies, peerDependencies, и optionalDependencies соответственно:
yarn add [package] --dev;
yarn add [package] --peer;
yarn add [package] --optional.

# Обновить зависимости:
yarn upgrade [package];
yarn upgrade [package]@[version];
yarn upgrade [package]@[tag].
yarn remove [package] — удалить зависимости.

# Установить все зависимости проекта.
yarn
# или
yarn install
