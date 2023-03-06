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
  def full_progress(start, finish)
    (start + self * (finish - start) / 100).round(2)
  end
end

# Float.send(:include, FloatFullProgress)
Float.include FloatFullProgress
