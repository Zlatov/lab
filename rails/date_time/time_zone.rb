ActiveSupport::TimeZone.all

Hash[ActiveSupport::TimeZone.all.map{|e| ["#{e.name} #{e.utc_offset/3600}",e.name]}]
# 
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
# 



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
