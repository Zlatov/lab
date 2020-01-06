# Bundler

Один из гемов, который позволяет управлять гемами приложения.

## Использование

```bash
bundle # установить из Gemfile.lock если есть, иначе установить по Gemfile и сформировать Gemfile.lock.
bundle config local.gem_name path/to/gem # Настроить на использование копии гема (в папке).
bundle config # Покажет специальные настройки.
bundle config --delete local.gem_name # Удалить специальную настройку для гема.
```
