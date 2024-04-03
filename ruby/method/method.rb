# encoding: UTF-8
require 'awesome_print'


puts 'return работает привычно в циклах, ага.'.green
def includes?
  [1,2,3].each do |e|
    return true if e == 2
    puts e
  end
  return false
end

result = includes?
print 'result: '.red; puts result


puts 'Лямбда метод'.green
a = lambda do |b, c|
  puts b + c
end
a.call 2, 3
print 'a: '.red; puts a
puts 'Лямбду можно сохранить в переменную и выполить потом'.blue
puts 'Proc не волнуют аргументы'.green
a = Proc.new { |x,y| puts "I don't care about arguments!" }
a.call
# exit 0


puts 'Лямбда и Прок по разному реагируют на return'.green
puts 'Лямбда делает свой возврат как самостоятельный метода и не прерывает того кто вызвал Лямбда'.blue
puts 'Прок делает return используя контекст места где был вызван call, то есть прервёт выполнение вызывающего метода.'.blue
# exit 0


puts 'Важно, Прок использует так же контекст создания.'.green
def call_proc(my_proc)
  count = 500
  my_proc.call
end
count   = 1
my_proc = Proc.new { puts count }
p call_proc(my_proc)
puts 'Вызов Прок был из метода, но Прок взял переменную из контекста своего Создания, а не Вызова.'.blue
# exit 0


puts 'Метод с лямбда для синглтон значения'.green
class A
  def brand
    @brand ||= lambda do
      puts '== calculate time'
      # Или без return:
      return Time.new.to_i
    end.call
  end
end
a = A.new
print 'a.brand: '.red; puts a.brand
# sleep 2
print 'a.brand: '.red; puts a.brand
# exit

puts 'Метод []'.green
class Asd
  CONST = [1, 2, 3]
  def self.[](key)
    CONST[key]
  end
end
print 'Asd[1]: '.red; puts Asd[1]
