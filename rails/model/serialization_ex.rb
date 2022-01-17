require 'awesome_print'
require 'active_support/all'
require 'active_model'

class A
  include ::ActiveModel::Serializers::JSON
  attr_reader :asd

  def initialize
    @asd = 1
  end

  def attributes
    {
      'asd' => nil
    }
  end
end

a = A.new.as_json
print 'a: '.red; puts a



