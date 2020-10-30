require 'awesome_print'

letter = ('a'..'z').to_a[rand(26)]
print 'letter: '.red; puts letter

word = Array.new(rand(3..12)){('a'..'z').to_a[rand(26)]}.join
print 'word: '.red; puts word

sentence = Array.new(rand(2..8)){Array.new(rand(3..12)){('a'..'z').to_a[rand(26)]}.join}.join(' ')
print 'sentence: '.red; puts sentence

# С заданной вероятностью возвращает true
def probability p
  p != 0 && rand <= p
end

sentence2 = Array.new(rand(2..8)) do |x|
  word = Array.new(rand(3..12)){('a'..'z').to_a[rand(26)]}.join;
  word.capitalize! if x==0;
  word.concat(',') if probability(0.2);
  word
end
  .join(' ').concat(' ' + Array.new(rand(3..12)){('a'..'z').to_a[rand(26)]}.join + '.')
print 'sentence2: '.red; puts sentence2
