## Вывод даты Через интернационализацию

Вьюха:

```
<%= l article.date, format: :short %>
```

Файл _config/locales/ru.yml_:

```yaml
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

## Вывод даты Через strftime

см `ruby/strftime/strftime.rb`


## Rails 7, использование config/initializers/time_formats.rb, .to_fs() и gem rails-i18n

```ruby
# Gemfile
gem 'rails-i18n', '~> 7.0.0'

# config/initializers/time_formats.rb
Time::DATE_FORMATS[:date] = lambda {|date| I18n.l(date, format: "%-e %B %Y")}
Date::DATE_FORMATS[:date] = lambda {|date| I18n.l(date, format: "%-e %B %Y")}
Time::DATE_FORMATS[:date_short] = "%d.%m.%y"
Date::DATE_FORMATS[:date_short] = "%d.%m.%y"
Time::DATE_FORMATS[:date_very_short] = lambda {|date| I18n.l(date, format: "%-e %b")}
Date::DATE_FORMATS[:date_very_short] = lambda {|date| I18n.l(date, format: "%-e %b")}

Time::DATE_FORMATS[:time] = "%T %:z"
Time::DATE_FORMATS[:time_short] = "%k:%M"

Time::DATE_FORMATS[:date_time] = lambda {|date| I18n.l(date, format: "%-e %B %Y, %T %:z")}
Time::DATE_FORMATS[:date_time_short] = "%d.%m.%y %k:%M"
Time::DATE_FORMATS[:date_time_very_short] = lambda {|date| I18n.l(date, format: "%-e %b, %k:%M")}


# app/views/.../index.html.erb
post.updated_at.to_fs(:date_time) # Формат из config/initializers/time_formats.rb
post.updated_at.to_fs(:db)             # 2025-03-16 18:54:37
post.updated_at.to_fs(:number)         # 20250316185437
post.updated_at.to_fs(:time)           # 18:54
post.updated_at.to_fs(:short)          # 16 Mar 18:54
post.updated_at.to_fs(:long)           # March 16, 2025 18:54
post.updated_at.to_fs(:long_ordinal)   # March 16th, 2025 18:54
post.updated_at.to_fs(:rfc822)         # Sun, 16 Mar 2025 18:54:37 +0300
post.updated_at.to_fs(:iso8601)        # 2025-03-16T18:54:37+0300
```
