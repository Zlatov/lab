class Car
  def self.number
    # ...
  end
end

# тоже самое, что и...

class Car; end
class << Car # мы внутри синглтон-класса класса Car
  def number
    # ...
  end
end

# тоже самое, что и...

class Car
  # self == Car, поэтому мы снова внутри синглтон-класса Car
  class << self
    def number
      # ...
    end
  end
end

# Или…

class Car; end

bmw = Car.new

class << bmw # мы внутри синглтон-класса объекта bmw
  def number
    'abc'
  end
end

# тоже самое, что и...

def bmw.number
  'abc'
end

puts bmw.number #=> 'abc'
