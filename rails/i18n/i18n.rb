require 'awesome_print'
require 'active_support/time'
require 'i18n'

date_time = DateTime.current
# https://ruby-doc.org/core-3.0.3/Time.html#method-i-strftime
format = '%Y.%m.%d'
format = '%d.%m.%y'
a = I18n.l(date_time, format: format)
print 'a: '.red; puts a
