class Cl
  @var
  attr_accessor :var

  @@var = 'value1'
  def self.var
    @@var
  end
  def self.var= value
    @@var = value
  end
  def inicialize
    # self.var = Cl.var
  end
  p @@var
end

p '--- --- --- --- --- --- --- --- --- ---'

instance = Cl.new

p Cl.var
Cl.var = 10
p Cl.var

p Cl.methods.include? :var
p Cl.instance_methods.include? :var
p Cl.singleton_methods.include? :var

