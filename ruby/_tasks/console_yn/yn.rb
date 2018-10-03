module Yn

  def self.Yn? question
    print "#{question} [YES|no]: "
    answer = ::STDIN.gets.chomp
    return false if (answer =~ /^n(?:o)?$/i) != nil
    return true
  end

  def self.yN? question
    print "#{question} [yes|NO]: "
    answer = ::STDIN.gets.chomp
    return true if (answer =~ /^y(?:es)?$/i) != nil
    return false
  end
end
