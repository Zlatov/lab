require 'awesome_print'

class IntegerCode
  SUM_START_CODE = 1000000
  DELTA = 5
  TIM = 8
  SUM_START_DECODE = SUM_START_CODE + DELTA * TIM
  def self.code int
    sum = SUM_START_CODE
    TIM.times do 
      sum = sum + DELTA
      int = int + delta(sum)
    end
    int
  end
  def self.decode int
    sum = SUM_START_DECODE
    TIM.times do 
      int = int - delta(sum)
      sum = sum - DELTA
    end
    int
  end
  def self.delta sum
    ((sum << 3) ^ 0b010101010101010 + 51) & 0b010101010101010
  end
end

(1..200).to_a.each do |data|
  coded = IntegerCode.code data
  decoded = IntegerCode.decode coded
  print 'data, coded, decoded: '.red; puts "#{data}, #{coded}, #{decoded}"
end
