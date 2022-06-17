require 'awesome_print'

def self.progress_from count
  index = 0
  yield(->() { index += 1; (index.to_f * 100 / count).round(4) })
end

array = (1..8).to_a

progress_from(array.length) do |progress_calculation|
  array.each do |value|
    print 'index: '.red; puts index
    progress = progress_calculation.call
    print 'index: '.red; puts index
    print 'b: '.red; puts b
  end
end
