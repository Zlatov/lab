# 
# Использование
# 
# В начале файла задач добавить код:
# ```
# require_relative '../extensions/task/output.rb'
# extend Task::Output
# ```
# В задаче поместить выполняемый код в блок метода output:
# ```
# task task_name: :environment do |t, args|
#   output t do
#     …
#   end
# end
# ```
# 
module Task


module Output

  def self.extended base
    ::Rake::TaskManager.record_task_metadata = true
  end

  def output task, args=nil
    time_start = Time.now
    puts "START #{task.name} в #{format_time time_start}".yellow
    puts "#{task.comment}".blue if task.comment.present?
    yield
    time_finish = Time.now
    puts "FINISH #{task.name} в #{format_time time_finish} выполнено за #{diff_time time_start, time_finish}".green
  end

  private

  def format_time time
    time.strftime("%Y-%m-%d %H:%M:%S")
  end

  # Возвращает строку "прошло времени" в днях, часах, минутах, секундах
  # возможен полный и краткий вариант, пример:
  # краткий вариант: "1 день 1 минута"
  # полный вариант:  "1 день 0 часов 1 минута 0 секунд"
  # @param [Int|Time] time_start_finish
  # @param [Int|Time] time_finish_start
  # @param [Hash|null] options
  # @return [String]
  # Зависимость: declension
  def diff_time time_start_finish, time_finish_start, options={full: false}
    diff_string = ''
    diff = (time_start_finish - time_finish_start).to_i.abs
    if diff >= 24 * 60 * 60 || options[:full]
      days = diff/(24 * 60 * 60)
      diff_string += "#{days} #{declension days, 'дней, день, дня'}"
      diff_string += " "
      diff = diff - days * 24 * 60 * 60
    end
    if diff >= 60 * 60 || options[:full]
      hours = diff/(60 * 60)
      diff_string += "#{hours} #{declension hours, 'часов, час, часа'}"
      diff_string += " "
      diff = diff - hours * 60 * 60
    end
    if diff >= 60 || options[:full]
      minutes = diff/(60)
      diff_string += "#{minutes} #{declension minutes, 'минут, минута, минуты'}"
      diff_string += " "
      diff = diff - minutes * 60
    end
    if diff > 0 || diff_string.empty? || options[:full]
      diff_string += "#{diff} #{declension diff, 'секунд, секунда, секунды'}"
    end
    diff_string
  end

  def declension number, words
    if words.is_a? ::String
      words = words.split(',').map{|v|v.strip}
    end
    words[1] = words[0] if (!words[1]||words[1].empty?)
    words[2] = words[1] if (!words[2]||words[2].empty?)
    number = number.abs%100
    if 11 <= number && number <= 19
      return words[0]
    end
    i = number%10
    case i
    when 1
      return words[1]
    when 2..4
      return words[2]
    else
      return words[0]
    end
  end
end


end
