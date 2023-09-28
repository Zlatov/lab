require 'awesome_print'
# require 'active_support/all'

# Включает методы на строках (`'Base'.safe_constantize`)
require "active_support/core_ext/string/inflections"

# Включает методы в корневом объекте (`safe_constantize('Base')`)
include ActiveSupport::Inflector


class Base
end

puts 'Есть ли класс/модуль?'.green
a = safe_constantize('Base')
b = 'Сase'.safe_constantize
print 'a: '.red; p a
print 'b: '.red; p b
# exit

puts 'Имя контроллера в класс (controller_name.classify)'.green
a = 'products'
b = a.classify
print 'a: '.red; p a
print 'b: '.red; p b
# exit
