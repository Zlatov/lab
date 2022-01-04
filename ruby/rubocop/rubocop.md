# Rubocop

Проверка синтаксиса

## Установка

```rb
# Gemfile

# Следим за кодом
gem 'rubocop', require: false
```

## Натсройка

```yaml
# Игнорировать отсутствие магического комментария:
# frozen_string_literal: true
# 
# Надо понимать что мы теряем производительность если не используем замороженные
# строки там где это возможно, применяйте!: ` -"неизменяемая строка" `
Style/FrozenStringLiteralComment:
  Enabled: false

# Надо понимать что есть качественное различие между
# 
# module Foo
#   class Bar
#   end
# end
# 
# и
# 
# class Foo::Bar
# end
# 
# Если где то в модуль вынесен код:
# 
# module Foo
#   X = 42
# end
# 
# то следует инициализировать модуль До класса-потомка, иначе ошибка. Как выход,
# рубокоп предлагает везде использовать первый синтаксис, а это некрасиво)
Style/ClassAndModuleChildren:
  Enabled: false

# Корячить пустые методы с точка-запятой, нет уж извините!
Style/EmptyMethod:
  Enabled: false

# Не даёт сравнимать с нуль (... == 0), заставляет переписывать на `.zero?`, как-то вообще не согласен!
Style/NumericPredicate:
  Enabled: false
```

## Настройка для Sublime Text

```json
// .../Packages/User/Default (Linux).sublime-keymap

  // Rubocop проверить текущий файл
  { "keys": ["alt+r"], "command": "rubocop_check_single_file" },
  // Применить автоисправления для текущего файла
  { "keys": ["ctrl+alt+r"], "command": "rubocop_auto_correct" },
```
