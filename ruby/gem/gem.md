# Gem

Система управления пакетами для языка программирования Руби.

```bash
gem --help
gem help commands

gem list # — список установленных гемов с версиями;
gem which gem_name # — где же гем gem_name;
cd $(dirname $(gem which nested_array)) # - перейти в катало с гемом (например для subl ./)
gem environment # — инфа обо всей гем среде (верия руби, рубигема, пути и т.д.);
gem list ^rails$ --remote --all # — посмотреть доступные версии пакета

gem install bundler #
gem install rails #
gem install rails -v 5.2.0 #
```

Можно обновить версию утилиты gem

```sh
gem install rubygems-update
update_rubygems
```




## Создание своего гема

```sh
# Создаст папку и необходимые файлы
bundle gem gem_name
cd gem_name

# Если необходимо - указать версию руби
rbenv local {ruby-version}

# Отредактировать prioritize.gemspec

# Установить зависимости
bundle install

# TDD-шить и разрабатывать функционал
bundle exec rake spec

# Проверять что-то в irb-консоли
./bin/console

# После того как все изменения готовы:
# 1. Меняем версию в lib/gem_name/version.rb.
# 2. Комитим пушим и устанавливаем такой же тэг версии.

# После написания функционала собираем гем (и устанавливается локально)
bundle exec rake install
# Или просто собираем для gem push
gem build

# Можно производить проверку в другом приложении

# Опубликовать гем
gem push ./pkg/{gem-version}.gem
```

## Ручное тестирование гема в проекте

```rb
# Указать path в Gemfile, затем bundle и перезапуск приложения. При изменениях в
# геме - перезапуск приложения:
# 
# Работа с древовидными массивами
gem "nested_array", path: "../nested_array"
```
