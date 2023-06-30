require 'rubygems'
require 'awesome_print'
require 'active_support/all'
require_relative '../integer/integer_declension'

module TimeDiff

  OPTIONS = {
    long_ago: 2.years,
    just_now: 5.minutes
  }

  TIMES = [
    'лет год года',
    'месяцев месяц месяца',
    'дней день дня',
    'часов час часа',
    'минут минута минуты',
    'секунда секунда секунды'
  ]
  TIMES_OTHER = [
    'лет года лет',
    'месяцев месяца месяцев',
    'дней деня дней',
    'часов часа часов',
    'минут минуты минут',
    'секунд секунды секунд'
  ]
  INDEX_FROM_TIME = {
    :years => 0,
    :months => 1,
    :weeks => 2,
    :days => 2,
    :hours => 3,
    :minutes => 4,
    :seconds => 5
  }

  def time_diff(time = nil, options = {})
    # Начальные параметры метода и возвращаемое значение по умолчанию.
    time ||= Time.current
    options = OPTIONS.merge options
    diff_strings = []

    diff_array = time_diff_array(time)

    first_diff, first_diff_index = *diff_array.map.with_index{|diff, index| [diff, index]}.select{|diff| diff[0] > 0}.first

    long_diff = nil
    long_diff_index = nil
    if options[:long_ago].present?
      long_time = options[:long_ago].parts.first[0]
      long_diff = options[:long_ago].parts.first[1]
      long_diff = long_diff * 7 if long_time == :weeks
      long_diff_index = INDEX_FROM_TIME[long_time]
    end
    if (
      first_diff.present? && first_diff_index.present? &&
      long_diff.present? && long_diff_index.present?
    ) && (
      first_diff_index < long_diff_index ||
      first_diff_index == long_diff_index && first_diff >= long_diff
    )
      return "больше #{first_diff} #{first_diff.declension(TIMES_OTHER[first_diff_index])}"
    end

    just_diff = nil
    just_diff_index = nil
    if options[:just_now].present?
      just_time = options[:just_now].parts.first[0]
      just_diff = options[:just_now].parts.first[1]
      just_diff = just_diff * 7 if just_time == :weeks
      just_diff_index = INDEX_FROM_TIME[just_time]
    end
    if (
      first_diff.present? && first_diff_index.present? &&
      just_diff.present? && just_diff_index.present?
    ) && (
      first_diff_index > just_diff_index ||
      first_diff_index == just_diff_index && first_diff < just_diff
    )
      return "только что"
    end

    diff_array.each.with_index do |diff, index|
      break if just_diff_index.present? && index > just_diff_index
      diff_strings.push "#{diff} #{diff.declension(TIMES[index])}" if diff > 0
    end
    diff_strings.join(', ')
  end

  def time_diff_array(time = nil)
    # Начальные параметры метода и возвращаемое значение по умолчанию.
    time ||= Time.current
    array = []

    start, finish = *([self, time].sort)

    years = finish.year - start.year
    years -= 1 if start + years.years > finish
    array.push years
    finish = finish - years.years if years > 0

    months = (finish.month - start.month) % 12
    months -= 1 if start + months.months > finish
    array.push months
    finish = finish - months.months if months > 0

    diff = (finish - start).to_i

    days = diff / 86400
    array.push days
    diff = diff - days * 86400 if days > 0

    hours = diff / 3600
    array.push hours
    diff = diff - hours * 3600 if hours > 0

    minutes = diff / 60
    array.push minutes
    diff = diff - minutes * 60 if minutes > 0

    seconds = diff
    array.push seconds

    array
  end
end

ActiveSupport::TimeWithZone.include TimeDiff
Time.include TimeDiff




a = Time.current
# b = a - 5.months - 1.days
b = a - 11.months - 30.days - 23.hours - 59.minutes - 59.seconds
p a.time_diff_array b
p b.time_diff_array a

# p a.time_diff(b)
# p b.time_diff(a)

p (Time.current).time_diff
p (Time.current - 5.minutes + 1.seconds).time_diff
p (Time.current - 5.minutes - 0.seconds).time_diff
p (Time.current - 2.hours - 2.minutes).time_diff
# p (Time.current - 2.years + 1.seconds).time_diff
# p (Time.current - 2.years - 1.seconds).time_diff
