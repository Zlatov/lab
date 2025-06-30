# ??? Если настроен часовой пояс, то можно использовать localtime
Sl.first.start
# => "2018-04-25 11:21:19 UTC"
Sl.first.start.localtime
# => 2018-04-25 14:21:19 +0300

# 
# Если вы хотите изменить часовой пояс Rails, но продолжайте сохранять Active
# Record в базе данных в UTC , используйте:
# _application.rb_
config.time_zone = 'Eastern Time (US & Canada)'
config.active_record.default_timezone = :utc # (по умолчанию)

# 
# Если вы хотите изменить часовой пояс Rails и иметь время хранения Active
# Record в этом часовом поясе, используйте:
# _application.rb_
config.time_zone = 'Eastern Time (US & Canada)'
config.active_record.default_timezone = :local

# Предупреждение : вам нужно подумать дважды, даже трижды, перед тем, как сохранять время в базе данных в формате, отличном от UTC.


ActiveSupport::TimeZone.all
ActiveSupport::TimeZone.instance_methods(false) # Даст понять что можно вызвать у инстанса кроме .name
ActiveSupport::TimeZone.all.second.name         # => "American Samoa" — человекочитаемое имя
ActiveSupport::TimeZone.all.second.tzinfo       # => #<TZInfo::DataTimezone: Pacific/Pago_Pago>
ActiveSupport::TimeZone.all.second.formatted_offset  # => "-11:00" — с учётом знака и двоеточия
ActiveSupport::TimeZone.all.second.utc_offset   # => -39600 — в секундах
ActiveSupport::TimeZone.all.second.now          # => текущее время в этой зоне

Hash[ActiveSupport::TimeZone.all.map{|e| ["#{e.name} #{e.utc_offset/3600}",e.name]}]
# Вернёт:
# ```
# {
#   …
#   "Moscow 3" => "Moscow",
#   …
#   "Vladivostok 3" => "Vladivostok",
#   …
# }
# ```
# 
# Позволит сделать селект с опциями:
# ```
# <optinon value="Moscow">Moscow 3</option>
# ```

ActiveSupport::TimeZone.all.map{|e| [e.formatted_offset, e.name]}
# => [["-12:00", "International Date Line West"],
#  ["-11:00", "American Samoa"],
# …


# Системное время.
> Time.now
=> 2015-07-04 17:53:23 -0400

# Установим временную зону Fiji.
> Time.zone = "Fiji"
=> "Fiji"

# Время осталось прежним - с временной зоной системы.
> Time.now
=> 2015-07-04 17:53:37 -0400

# Однако предварительно использовав метод `zone`, мы получим время Fiji
> Time.zone.now
=> Sun, 05 Jul 2015 09:53:42 FJT +12:00

# Мы можем использовать метод `current` для получения того - же эффекта.
> Time.current
=> Sun, 05 Jul 2015 09:54:17 FJT +12:00

# Или перевести системное время во время приложения использовав метод `in_time_zone`
> Time.now.in_time_zone
=> Sun, 05 Jul 2015 09:56:57 FJT +12:00

# То же с датой.
> Date.today
=> Sat, 04 Jul 2015

# Дата приложения.
> Time.zone.today
=> Sun, 05 Jul 2015

# And gives us the correct tomorrow according to our application's time zone
> Time.zone.tomorrow
=> Mon, 06 Jul 2015

# Going through Rails' helpers, we get the correct tomorrow as well
> 1.day.from_now
=> Mon, 06 Jul 2015 10:00:56 FJT +12:00


# DON’T USE
Time.now
Date.today
Date.today.to_time
Time.parse("2015-07-04 17:05:37")
Time.strptime(string, "%Y-%m-%dT%H:%M:%S%z")

# DO USE
Time.current
2.hours.ago
Time.zone.today
Date.current
1.day.from_now
Time.zone.parse("2015-07-04 17:05:37")
Time.strptime(string, "%Y-%m-%dT%H:%M:%S%z").in_time_zone

# Миграция
def change
  add_column :affiliates, :time_zone, :string, null: false, default: 'UTC'
end

# Модель
  enum time_zone: ::Hash[::ActiveSupport::TimeZone.all.map{|e| [e.name, e.name]}]

# Вывод времени

# 
# Пример
# ```
# Заказ № <%= order.id %>, # от <%= date_time order.created_at, time_zone: @client.affiliate.time_zone %>
# ```
module DateTimeHelper

  def date_time date_time, options = {}
    date_time = date_time.in_time_zone options[:time_zone] if options[:time_zone].present?
    format = '%e %B %Y, %T %:z'
    I18n.l(date_time, format: format)
  end

  def date date_or_date_time, options = {}
    date_time = date_or_date_time
    date_time = date_time.in_time_zone options[:time_zone] if options[:time_zone].present?
    format = '%d %B %Y'
    I18n.l(date_time, format: format)
  end

  def time time_or_date_time, options = {}
    date_time = time_or_date_time
    date_time = date_time.in_time_zone options[:time_zone] if options[:time_zone].present?
    date_time.strftime '%T %:z'
  end
end
