# require "pp"

class Cl
  # @var
  @var = 'value1'
  def initialize
    # @var
    @var = @var
    # @var = 'value2'
  end
  attr_accessor :var
  p @var
  # @var = 'value'
  # attr_reader :var
  # attr_reader :some_reader_for_var
  # def some_reader_for_var
  #   @var
  # end
  # def var
  #   # @var
  #   @var = 'value2'
  # end
end

instance1 = Cl.new

# p instance1
p instance1.var
# p instance1.some_reader_for_var
