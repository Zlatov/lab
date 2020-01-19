# Bundler

Один из гемов, который позволяет управлять гемами приложения.

## Использование

```bash
bundle # установить из Gemfile.lock если есть, иначе установить по Gemfile и сформировать Gemfile.lock.
```

__Подмена гемов для тестирования__

1. Настройка bundle

```
bundle config local.gem_name path/to/gem # Настроить на использование копии гема (в папке).
bundle config # Покажет специальные настройки.
bundle config --delete local.gem_name # Удалить специальную настройку для гема.
```

2. Настройка Gemfile

_более очевидная и простая в работе_
_осторожно! не запушить на продакшн!_

gem 'nested_array', path: '/home/iadfeshchm/projects/my/nested_array'
