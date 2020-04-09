# encoding: UTF-8
require 'awesome_print'

require 'active_support'
require 'active_support/core_ext'

a = Math::PI * 0.5
b = Math.sin a
print 'b: '.red; puts b

a = 1
b = Math.asin(a)/Math::PI
print 'b: '.red; puts b


# latitude - широта
# longitude - долгота
def rasstoyanie latitude_a, longitude_a, latitude_b, longitude_b
  radius = 6371 # Радиус земли [км].
  radian_latitude_a  = latitude_a  * Math::PI / 180
  radian_longitude_a = longitude_a * Math::PI / 180
  radian_latitude_b  = latitude_b  * Math::PI / 180
  radian_longitude_b = longitude_b * Math::PI / 180
  delta = Math.acos(
    Math.sin(radian_latitude_a) * Math.sin(radian_latitude_b) +
    Math.cos(radian_latitude_a) * Math.cos(radian_latitude_b) * Math.cos(radian_longitude_a - radian_longitude_b)
  )
  rasstoyanie = delta * radius
end

a = rasstoyanie 55.56142080000001, 38.223872, 55.859385, 37.8141186
a = rasstoyanie 56.025857, 37.854891, 55.859385, 37.8141186
print 'a: '.red; puts a
a = rasstoyanie 0, 0, 0, 180
print 'a: '.red; puts a
a = rasstoyanie 0, 0, 180, 0
print 'a: '.red; puts a
a = rasstoyanie 0, 0, 0, 1
print 'a: '.red; puts a
