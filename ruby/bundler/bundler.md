# Bundler

Один из гемов, который позволяет управлять гемами приложения.

## Установка

`gem install bundler`

Создать файл Gemfile с содержимым:

```ruby
source 'https://rubygems.org'

gem 'awesome_print'

```

## Использование

```bash
bundle # установить из Gemfile.lock если есть, иначе установить по Gemfile и сформировать Gemfile.lock.
bundle info <gem_name> # узнать какую версию использует приложение и где она лежит физически.
```

### Подмена гемов для тестирования

1. Настройка bundle

```
bundle config local.gem_name path/to/gem # Настроить на использование копии гема (в папке).
bundle config # Покажет специальные настройки.
bundle config --delete local.gem_name # Удалить специальную настройку для гема.
```

2. Настройка Gemfile

_более очевидная и простая в работе_
_осторожно! не запушить на продакшн!_

```ruby
gem 'nested_array', path: '/home/iadfeshchm/projects/my/nested_array'
# или относительный путь
gem 'nested_array', path: '../nested_array'
```

### Управление версионностью из файла Gemfile

Пессимистическое ограничение диапазона версий MAJOR.MINOR.PATCH

```ruby
gem 'nokogiri', '1.0.0'                                          # Фиксирует версию
gem 'nokogiri', '~> 1.0'   gem 'nokogiri', '>= 1.0', '< 2.0'     # Увеличивает минорные и патч версии
gem 'nokogiri', '~> 1.5.0' gem 'nokogiri', '>= 1.5.0', '< 1.6.0' # Увеличивает патч версии
gem 'nokogiri', '~> 1.5.3' gem 'nokogiri', '>= 1.5.3', '< 1.6.0' # Увеличивает патч версии
```

__Доступные операторы__

RubyGems предоставляет полный набор операторов версий, которые позволяют вам указать, с какими версиями гема может работать ваше приложение. Если вы не используете оператор и просто используете номер версии, вы привязываете свое приложение к этой конкретной версии, это сокращение от использования оператора равенства (=).

Список операторов, поддерживаемых в RubyGems:

* `=  ` Equal to (default)
* `!= ` Not equal to
* `>  ` Greater than
* `<  ` Less than
* `>= ` Greater than or equal to
* `<= ` Less than or equal to
* `~> ` Пессимистическое ограничение диапазона версий

## Ошибки и решения

Ошибка `bundle`: "An error occurred while installing therubyracer (0.12.2), and Bundler cannot continue".

Помогло:

```bash
sudo apt-get install g++
sudo apt-get install build-essential
```
