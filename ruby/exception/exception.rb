require 'awesome_print'
require 'active_support'
require 'active_support/core_ext'

class C1

  class Error < StandardError

    ERRORS = {
      no_args: 'Нет аргумента для ф-ии meth'
    }

    def initialize key_or_message=nil
      message = nil
      message = key_or_message if key_or_message.is_a?(String)
      message = ERRORS[key_or_message] if key_or_message.is_a?(Symbol) && ERRORS.keys.include?(key_or_message)
      super(message)
    end
  end

  def meth arg=nil
    raise Error.new :no_args if arg.blank?
    return arg
  end
end

begin
  a = C1.new
  print 'a: '.red; puts a
  a.meth
rescue C1::Error => e
  puts 'Словлена кастомная ошибка.'.green
  # Rails.logger.error '>>> Ошибка.'
  # Rails.logger.error e.message
  # Rails.logger.error e.backtrace.join("\n")
  Rails.logger.error "#{e.message}\n#{e.backtrace.join("\n")}"
  puts '>>> Ошибка.'
  puts e.message
  puts e.backtrace.join("\n")
  print 'e.message: '.red; puts e.message
end
