require 'awesome_print'
require 'active_support'


module M
  extend ActiveSupport::Concern
  
  included do |base|
    attr_accessor :instance_variable
  end

  class_methods do
    attr_reader :accessors

    def config_accessors(*params)
      @accessors = params
      params.each do |access_to|
        send(:attr_accessor, access_to)
      end
    end
  end
end


class A
  include M

  def initialize(options = {})
    @instance_variable = options[:instance_variable]
  end

  config_accessors :one, :two
end

class Aa < A
  config_accessors :asd, :zxc
end

puts 'Итого'.green
print 'A.accessors: '.red; p A.accessors
print 'Aa.accessors: '.red; p Aa.accessors

puts 'Нормальный аксессор'.green
a = A.new instance_variable: 'A'
aa = Aa.new instance_variable: 'Aa'
print 'a.instance_variable: '.red; puts a.instance_variable
print 'aa.instance_variable: '.red; puts aa.instance_variable

puts 'Динамические аксессоры'.green
print 'a.one: '.red; puts a.one
print 'a.two: '.red; puts a.two
print 'aa.asd: '.red; puts aa.asd
print 'aa.zxc: '.red; puts aa.zxc
