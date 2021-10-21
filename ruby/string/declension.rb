# Для включения в rails создайте config/initializers/extensions.rb со следующим
# кодом: require 'integer_declension.rb'
# 
# lib/integer_declension.rb
module IntegerDeclension

  # 12.declension 'стульев стул стула'
  # 0.declension 'случайных ошибок', 'случайная ошибка', 'случайных ошибки'
  # 1.declension ['массивов', 'массив', 'массива']
  def declension *params
    if params.length == 1 && params[0].is_a?(String)
      words = params[0].split "\s"
    elsif params.length > 1
      words = params
    elsif params[0].is_a? Array
      words = params[0]
    else
      return ''
    end
    words[1] = words[0] if words[1].nil? || words[1].empty?
    words[2] = words[1] if words[2].nil? || words[2].empty?
    number = self.abs % 100
    if number.between? 11, 19
      return words[0]
    end
    case number % 10
    when 1
      return words[1]
    when 2..4
      return words[2]
    else
      return words[0]
    end
  end
end

Integer.send(:include, IntegerDeclension)

40.times{ |i|
  puts "#{i} #{i.declension 'ежей ёж ежа'}"
}
40.times{ |i|
  puts "#{i} #{i.declension ['ошибок не позволило', 'ошибка не позволила', 'ошибки не позволили']}"
}
