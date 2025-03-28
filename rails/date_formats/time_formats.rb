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




# Rails 7
Time.zone.now.to_fs(:symbol)
Time.zone.now.to_formatted_s(:symbol)
# Rails ниже 7
Time.zone.now.to_s(:symbol)
# :symbol   И   :time
  :db           2025-03-28 10:25:42
  :number       20250328102542
  :time         10:25
  :short        28 Mar 10:25
  :long         March 28, 2025 10:25
  :long_ordinal March 28th, 2025 10:25
  :rfc822       Fri, 28 Mar 2025 10:25:42 +0300
  :iso8601      2025-03-28T10:25:42+0300
