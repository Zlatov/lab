require 'awesome_print'

class Polygon
  # Переменная класса, которая будет менять своё значение при присваивании новых
  # значений в дочерних классах.
  @@sides = 6
  # Для создания доустпа к переменной класса нельзя применять метод:
  # class << self; attr_reader :sides end
  # так как он создаёт код доступа к переменной инстанса:
  # def self.sides; @sides end
  def self.sides
    @@sides
  end

  # "Переменная экземпляра класс-уровня", инстансная переменная класса - класс
  # есть инстанс-объект со своими инстансными переменными.
  # @max_sides = nil
  class << self
    attr_reader :max_sides
  end
  # или
  def self.max_sides
    @max_sides
  end
end

puts 'Переменная родительского класса:'.green
print 'Polygon.sides: '.red; puts Polygon.sides

class Triangle < Polygon
  @@sides = 3
  @max_sides = 3
end

puts 'Дочерний будет переопределять переменную родительского:'.green
print 'Polygon.sides: '.red; puts Polygon.sides
print 'Triangle.sides: '.red; puts Triangle.sides

class Kvadrat < Polygon
  @@sides = 4
  @max_sides = 4
end

puts 'Дочерний будет переопределять переменную родительского и все "братские" классы приймут это значение соответственно:'.green
print 'Polygon.sides: '.red; puts Polygon.sides
print 'Triangle.sides: '.red; puts Triangle.sides
print 'Kvadrat.sides: '.red; puts Kvadrat.sides

puts 'Мы хотим чтобы дочерние классы не влияли на предка и друг на друга изменяя общую переменную.'.green
print 'Polygon.max_sides: '.red; puts Polygon.max_sides
print 'Triangle.max_sides: '.red; puts Triangle.max_sides
print 'Kvadrat.max_sides: '.red; puts Kvadrat.max_sides
