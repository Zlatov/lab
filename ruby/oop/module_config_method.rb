require 'awesome_print'
require "active_support"


module M
  extend ActiveSupport::Concern

  class_methods do
    attr_accessor :config_value

    def config(value)
      puts 'config'
      @config_value = value
    end
  end
end


class A
  include M

  config 'valueA'
end

class Aa < A
  config 'valueAa'
end

print 'A.config_value: '.red; puts A.config_value
print 'Aa.config_value: '.red; puts Aa.config_value
A.config_value = '111'
Aa.config_value = '222'
print 'A.config_value: '.red; puts A.config_value
print 'Aa.config_value: '.red; puts Aa.config_value
