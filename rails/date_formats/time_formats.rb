# config/initializers/time_formats.rb
# Данная настройка позволяет заранее настроить форматы дат для их рендера:
# Post.first.published.to_s(:date_short)

# Time::DATE_FORMATS[:month_and_year] = "%B %Y"
# Time::DATE_FORMATS[:short_ordinal] = lambda { |time| time.strftime("%B #{time.day.ordinalize}") }

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
