class Cl
  @var = 'value1'
  def initialize
    @var = 'value2'
  end
  attr_reader :var
  # def var
  #   @var = 'value2'
  # end
  p @var
end

instance1 = Cl.new

p instance1.var
p Cl.methods.include? :var
p Cl.instance_methods.include? :var
p Cl.singleton_methods.include? :var

