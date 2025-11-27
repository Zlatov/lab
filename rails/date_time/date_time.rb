require 'awesome_print'
require 'mini_magick'
require 'active_support/all'

print 'Time.current.to_s: '.red; puts Time.current.to_s
print 'Time.parse(Time.current.to_s): '.red; puts Time.parse(Time.current.to_s)
Time.zone = 'Moscow'
print 'Time.zone.parse(Time.current.to_s): '.red; puts Time.zone.parse(Time.current.to_s)
p I18n.l(Time.parse(Time.current.to_s), format: '%-e %B %Y, %T %:z')
# exit

a = '1641817394'
b = Time.at a.to_i
print 'b: '.red; puts b
# exit

puts 'В строку и обратно'.green
a = DateTime.parse DateTime.current.to_s
print 'a: '.red; puts a

puts 'В строку и обратно'.green
a = Time.parse Time.current.to_s
print 'a: '.red; puts a
Time.zone = "Fiji"
print 'Time.zone: '.red; puts Time.zone
a = Time.zone.parse Time.current.to_s
print 'a: '.red; puts a


# print 'ActiveSupport::TimeZone::MAPPING: '.red; p ActiveSupport::TimeZone::MAPPING
# print 'ActiveSupport::TimeZone.all: '.red; p ActiveSupport::TimeZone.all
moscow_zone = ActiveSupport::TimeZone::MAPPING['Moscow']
print 'moscow_zone: '.red; puts moscow_zone
ActiveSupport::TimeZone.all.each do |zone|
  if zone.name == 'Moscow'
    puts zone
    puts zone.utc_offset
    puts zone.tzinfo
  end
end

puts 'Разница между двумя временами в секундах'.green
a = DateTime.current
b = DateTime.current - 10.seconds
print 'a: '.red; puts a
print 'b: '.red; puts b
c = ((a - b) * 24 * 60 * 60).to_i
print 'c: '.red; puts c

a = Time.current
b = Time.current - 10.seconds
print 'a: '.red; puts a
print 'b: '.red; puts b
c = (a - b).to_i
print 'c: '.red; puts c


puts 'Если нужен формат даты как БД (0000-00-00)'.green
puts 'При передаче Date.current в «ActiveRecord», последний видит объект и преобразует в нужный формат'.blue
a = Date.current
print 'a: '.red; p a.inspect
a = Time.current.strftime('%Y-%m-%d')
print 'a: '.red; p a
a = Time.current.strftime('%F')
print 'a: '.red; p a
a = Date.current.strftime('%F')
print 'a: '.red; p a
