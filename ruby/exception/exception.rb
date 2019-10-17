require 'awesome_print'
require 'active_support'
require 'active_support/core_ext'

class C1

  class Error < StandardError
  end

  def meth arg=nil
    raise Error.new if arg.blank?
    return arg
  end
end

begin
  a = C1.new
  print 'a: '.red; puts a
  a.meth
rescue C1::Error => e
  puts 'Словлена кастомная ошибка.'.green
end
