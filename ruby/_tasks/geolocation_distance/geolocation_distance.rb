require 'awesome_print'
require 'active_support/all'

puts 'Для начала опробуем тригонометрические функции'.green
a = 90.0 # Градусов
b = a*Math::PI/180
c = Math.sin(b)
d = Math.cos(b)
print 'a: '.red; puts a
print 'b: '.red; puts b
print 'c: '.red; puts c.round(6)
print 'd: '.red; puts d.round(6)

a = 1
b = Math.acos(a)
c = Math.asin(a)
print 'a: '.red; puts a
print 'b: '.red; puts b
print 'c: '.red; puts c

puts 'Сравним угловые расстояния у экватора и ближе к полюсу'.green
# Угловое расстояние между двумя точками на сфере.
# φ1, λ1; φ2, λ2 - широта и долгота двух точек в радианах.
# Δλ — разница координат по долготе.
# Δδ = arccos(sin φ1 sin φ2 + cos φ1 cos φ2 cos Δλ)
def angular_distance a_lat_deg, a_lon_deg, b_lat_deg, b_lon_deg
  a_lat = a_lat_deg * Math::PI / 180
  a_lon = a_lon_deg * Math::PI / 180
  b_lat = b_lat_deg * Math::PI / 180
  b_lon = b_lon_deg * Math::PI / 180
  Math.acos(Math.sin(a_lat) * Math.sin(b_lat) + Math.cos(a_lat) * Math.cos(b_lat) * Math.cos(a_lon - b_lon))
end
delta = angular_distance(0.0, 100.0, 0.0, 101.0)
print 'Один градус долготы на экваторе delta: '.red; puts delta
delta = angular_distance(60.0, 100.0, 60.0, 101.0)
print 'Один градус долготы на 60-ой широте delta: '.red; puts delta
delta = angular_distance(89.0, 100.0, 89.0, 101.0)
print 'Один градус долготы на 89-ой широте =) delta: '.red; puts delta
delta = angular_distance(0.0, 0.0, 1.0, 0.0)
print 'Один градус широты на 0-ой долготе delta: '.red; puts delta
delta = angular_distance(0.0, -180.0, 1.0, -180.0)
print 'Один градус широты на -180-ой долготе delta: '.red; puts delta
delta = angular_distance(89.0, -180.0, 90.0, -180.0)
print 'Один градус широты на -180-ой долготе у полюса delta: '.red; puts delta
delta = angular_distance(0.0, 0.0, 0.0, 180.0)
print 'Максимальное расстояние на экваторе delta: '.red; puts delta
delta = angular_distance(90.0, 100.0, -90.0, 180.0)
print 'Расстояние между полюсами delta: '.red; puts delta
