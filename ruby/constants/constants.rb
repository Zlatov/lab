MY_CONST = 0

class A

  MY_CONST = 1
  MY_CONST2 = MY_CONST + 1

  # # Это не константа:
  # my_const = 2

  def self.print_const
    puts "Значение глобальной константы: #{::MY_CONST}"
    puts "Значение моей константы: #{MY_CONST}"
    puts "Значение моей константы2: #{MY_CONST2}"
  end

  def print_const
    puts "Значение глобальной константы: #{::MY_CONST}"
    puts "Значение моей константы: #{self.class::MY_CONST}"
    puts "Значение моей константы2: #{self.class::MY_CONST2}"
    puts "Значение моей константы clear syntax: #{MY_CONST}"
    puts "Значение моей константы2 clear syntax: #{MY_CONST2}"
  end
end

puts MY_CONST

puts A::MY_CONST

puts A::MY_CONST2

# # Выведет ошибку undefined method my_const
# puts A::my_const

A.print_const

A.new.print_const
