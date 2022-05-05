require 'awesome_print'
require 'active_support/all'

p Time.parse(Time.current.to_s)
Time.zone = 'Moscow'
p Time.zone.parse(Time.current.to_s)
p I18n.l(Time.parse(Time.current.to_s), format: '%e %B %Y, %T %:z')
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
