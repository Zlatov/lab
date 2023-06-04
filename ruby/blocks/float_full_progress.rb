require 'awesome_print'

# Перерасчёт прогресса подзадачи в глобальный прогресс общей задачи.
#
# Часто в разного рода задач типа импорт необходимо выводить процент выполненной
# задачи, хорошо, когда в задаче единственный перебор чего-либо и в нём легко
# рассчитать процент:
#
# count = 150
# (0...count).each do |i|
#   progress = ((i + 1).to_f * 100 / count).round(2)
# end
#
# Но в задаче более одного перебора необходимо локальный процент перебора
# пересчитать в глобальный, с учетом того - сколько процентов выделяется на
# локальную задачу:
#
# count = 150
# (0...count).each do |i|
#   progress = ((i + 1).to_f * 100 / count).round(2)
#   progress.full_progress(0, 40)
# end
# count = 180
# (0...count).each do |i|
#   progress = ((i + 1).to_f * 100 / count).round(2)
#   progress.full_progress(40, 100)
# end
module FloatFullProgress
  # Если известно сколько процентов выделяется на локальную задачу (от start, до
  # finish).
  def full_progress(start, finish)
    (start + self * (finish - start) / 100).round(2)
  end
end

module IntegerProgress
  # Расчёт прогресса
  #
  # Где
  # self - индекс выполняемой операции, обычно 0...count;
  # count - количество операций (обратите внимание, это не последний индекс).
  def progress(count)
    ((self + 1).to_f * 100 / count).round(2)
  end

  # Расчёт полного прогресса при известном прогрессе текущей операции
  # (current_progress)
  #
  # Где
  # self - индекс выполняемой операции, обычно 0...count;
  # count - количество операций (обратите внимание, это не последний индекс);
  # current_progress - прогрессе текущей операции.
  #
  # Например:
  # (0...2).each_with_index do |model, index|
  #   (0...9).each_with_index do |submodel, subindex|
  #     subprogress = subindex.progress(9) # Подпрогресс
  #     full_progress = index.full_progress(2, subprogress) # Прогресс с учётом подпрогресса
  #   end
  #   progress = index.progress(2) # Прогресс без учёта подпрогресса
  # end
  def full_progress(count, current_progress)
    ((self.to_f * 100 + current_progress) / count).round(2)
  end
end

# Float.send(:include, FloatFullProgress)
Float.include FloatFullProgress
Integer.include IntegerProgress

puts 'Пример расчёта полного прогресса при известных процентах выделяемых на задачу (от 0% до 40%)'.green
count = 15
(0...count).each do |i|
  progress = i.progress(count)
  print 'progress: '.red; puts progress
  full_progress = progress.full_progress(0, 40)
  print 'full_progress: '.red; puts full_progress
end

puts 'Пример расчёта полного прогресса при известном прогрессе текущей задачи'.green
(0...2).each_with_index do |model, index|
  (0...9).each_with_index do |submodel, subindex|
    subprogress = subindex.progress(9)
    full_progress = index.full_progress(2, subprogress)
    print 'full_progress (с учётом подпрогресса): '.red; puts full_progress
  end
  progress = index.progress(2)
  print 'progress (без учёта подпрогресса): '.red; puts progress
end
