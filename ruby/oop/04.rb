require_relative '../colorize/colorize.rb'

class Cl

  @@var
  def self.var
    @@var
  end
  def self.var= value
    @@var = value
  end

  @foo
  # attr_accessor :foo
  # attr_reader :foo
  # attr_writer :foo
  def foo
    @foo
  end
  def foo= value
    @foo = value
  end

  class << self
    p self
    def quux
      p self
      puts "I am a singleton method for self and a class method for Cl"
    end
  end

end

instance = Cl.new

def instance.bar
  puts "I am a singletone method"
end

class << instance
  def baz
    puts "I am a singleton method"
  end
end

print "\n--- --- --- --- method #{"var".red} --- --- --- --- ---\n";
print 'class has method var: '; p Cl.methods.include? :var
print 'class has instance_methods var: '; p Cl.instance_methods.include? :var
print 'class has singleton_methods var: '; p Cl.singleton_methods.include? :var
print 'instance has method var: '; p instance.methods.include? :var

print "\n--- --- --- --- method #{"foo".red} --- --- --- --- ---\n"
print 'class has method foo: '; p Cl.methods.include? :foo
print 'class has instance_methods foo: '; p Cl.instance_methods.include? :foo
print 'class has singleton_methods foo: '; p Cl.singleton_methods.include? :foo
print 'instance has method foo: '; p instance.methods.include? :foo

print "\n--- --- --- --- method #{"bar".red} --- --- --- --- ---\n"
print 'class has method bar: '; p Cl.methods.include? :bar
print 'class has instance_methods bar: '; p Cl.instance_methods.include? :bar
print 'class has singleton_methods bar: '; p Cl.singleton_methods.include? :bar
print 'instance has method bar: '; p instance.methods.include? :bar

print "\n--- --- --- --- method #{"baz".red} --- --- --- --- ---\n"
print 'class has method baz: '; p Cl.methods.include? :baz
print 'class has instance_methods baz: '; p Cl.instance_methods.include? :baz
print 'class has singleton_methods baz: '; p Cl.singleton_methods.include? :baz
print 'instance has method baz: '; p instance.methods.include? :baz

print "\n--- --- --- --- method #{"quux".red} --- --- --- --- ---\n"
print 'class has method quux: '; p Cl.methods.include? :quux
print 'class has instance_methods quux: '; p Cl.instance_methods.include? :quux
print 'class has singleton_methods quux: '; p Cl.singleton_methods.include? :quux
print 'instance has method quux: '; p instance.methods.include? :quux

Cl.quux

# p '--- --- --- --- private --- --- --- --- ---'
# p Cl.private_methods.include? :var
# p Cl.private_instance_methods.include? :var
# p instance.private_methods.include? :var

# p '--- --- --- --- public --- --- --- --- ---'
# p Cl.public_methods.include? :var
# p Cl.public_instance_methods.include? :var
# p instance.public_methods.include? :var
