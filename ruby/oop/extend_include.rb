# include - включаем в каждый инстанс методы: MyApp.new.echo_run
# extend - расширяем класс: MyApp.echo_run

# file3:
module Command
  module Test

    def echo_test
      puts 'test'
      self
    end
  end
end

# file2:
# require_relative "file3"
module Command

  include Test

  def echo_run
    puts 'run'
    self
  end
end

# require_relative "file2"
class MyApp

  include Command # Включаем в каждый инстанс методы: MyApp.new.echo_run
  extend Command # Расширяем класс: MyApp.echo_run
end

MyApp.new.echo_run.echo_test
MyApp.echo_run.echo_test
