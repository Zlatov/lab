require 'awesome_print'

class Lorem

  def initialize
    @a = 1
  end
end

a = Lorem.new
print 'a: '.red; puts a
