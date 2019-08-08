# Вывод даты

## Через интернационализацию

Вьюха:

```
<%= l article.date, format: :short %>
```

Файл _config/locales/ru.yml_:

```
  # Дефолтный конфиг интернационализации
  # для расширения текущего
  # см. на
  # https://github.com/svenfuchs/rails-i18n/blob/master/rails/locale/ru.yml
  date:
    formats:
      default: "%Y-%m-%d"
      short: "%-d %b %Y"
    abbr_month_names:
      - 
      - янв.
      - февр.
      - марта
      - апр.
      - мая
      - июня
      - июля
      - авг.
      - сент.
      - окт.
      - нояб.
      - дек.
```

## Через strftime

см `ruby/strftime/strftime.rb`
