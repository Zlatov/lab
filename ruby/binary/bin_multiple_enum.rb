# Задача: полю модели может сответствовать одно или несколько значений
# (свойств) из фиксированного списка, то есть как enum в рельсе, но хранит в
# себе несоклько выбранных значений (свойств), а не одно. Необходимо
# зашифровать спискок значений в числе используя двоичный код.

require 'awesome_print'

puts 'Каждому свойству назначим ключ-маску по типу: 00100'.green
A = 1 << 0
B = 1 << 1
C = 1 << 2
D = 1 << 3
properties = [A, B, C, D]
print 'A: '.red; puts "%1$d (%1$b)" % A
print 'B: '.red; puts "%1$d (%1$b)" % B
print 'C: '.red; puts "%1$d (%1$b)" % C
print 'D: '.red; puts "%1$d (%1$b)" % D

puts 'Вычисляем (кодируем) число из массива назначенных свойств'.green
values = [2, 4, 1]
number = values.inject(0){|sum, mask| sum | mask}
print 'values: '.red; p values
print 'number: '.red; p "%1$d (%1$b)" % number
# exit

puts 'Вычисляем (декодируем) массив назначенных свойств из числа'.green
number = 10
values = properties.select{|mask| number & mask == mask}
print 'number: '.red; p "%1$d (%1$b)" % number
print 'values: '.red; p values
# exit

# Пост может иметь одну или несколько социальных сетей.
class Post

  SOCIALS = [:asd, :zxc, :qwe]
  attr_accessor :social
  def social
    SOCIALS.select.with_index do |value, index|
      mask = 1 << index
      @social & mask == mask
    end
  end
  def social=(values)
    values ||= []
    values.map!(&:to_sym)
    @social = values.inject(0) do |sum, value|
      index = SOCIALS.index(value)
      mask = index.nil? ? 0 : 1 << index
      sum | mask
    end
  end
  def social_ids=(ids)
    ids ||= []
    @social = ids.inject(0) do |sum, id|
      mask = 1 << id
      sum | mask
    end
    @social
  end
end

post = Post.new
print 'post: '.red; p post
print 'post.social: '.red; p post.social

post.social_ids = [2, 0]
print 'post.social: '.red; p post.social

post.social = [:zxc, "qwe"]
print 'post.social: '.red; p post.social

post.social = nil
print 'post.social: '.red; p post.social

post.social_ids = [0]
print 'post.social: '.red; p post.social

post.social_ids = nil
print 'post.social: '.red; p post.social
