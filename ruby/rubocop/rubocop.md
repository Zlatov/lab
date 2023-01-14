# Rubocop

Проверка синтаксиса

## Установка

```rb
# Gemfile

# Следим за кодом
gem 'rubocop', require: false
```

Наполнить .rubocop.yml


## Настройка для Sublime Text

```json
// .../Packages/User/Default (Linux).sublime-keymap

  // Rubocop проверить текущий файл
  { "keys": ["alt+r"], "command": "rubocop_check_single_file" },
  // Применить автоисправления для текущего файла
  { "keys": ["ctrl+alt+r"], "command": "rubocop_auto_correct" },
```
