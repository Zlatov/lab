# encoding: UTF-8
require 'awesome_print'
require 'date'

# 
# Не ловите все ошибки! иначе вы их не увидите а они будут, не делайте так:
# 
# begin
#   ...
# rescue Exception => e
#    puts e.message
# end
# 
# Класс Exception — корень иерархии исключений Ruby, поэтому, когда мы ловим
# и далее не пробрасываем (то есть спасаем) Exception, тогда мы спасаеме все, включая такие как подклассы SyntaxError, LoadError и Interrupt:
# * Interrupt не позволяет пользователю использовать CTRL C для выхода из программы;
# * SignalException не позволяет программе правильно реагировать на сигналы, за исключением kill -9;
# * SyntaxError означает, что eval, который завершится неудачей, сделает это тихо.
# 
# Делайте так:
# 
# begin
#   ...
# rescue => e
#   ...
# end
# 
# Что эквивалентно:
# 
# begin
#   ...
# rescue StandardError => e
#   ...
# end
# 

begin

  if true
    raise 'Что-то не так.'
  end

  begin
    p 1/0
  rescue => e
    p 'Что-то пошло не так при делении, делаем что-то, чтобы интерфейс пользователя не умер.'
    p e.message
    raise e
  ensure
    p 'Но мы всёравно выполнили это после деления.'
  end

rescue => e
  p 'В приложении ошибка:'
  p e.message
ensure
  p 'Но мы всёравно выполнили это.'
end

# Очень не рекомендуют делать однострочные rescue:
# a = DateTime.strptime('мусор', "%Y-%m-%d") rescue nil
begin
  a = DateTime.strptime('мусор', "%Y-%m-%d")
rescue ArgumentError => e
  a = "false"
end
print 'a: '.red; puts a

# Полный синтаксис rescue
begin
  puts 'begin'.green
rescue SomeExceptionClass => some_variable
  puts 'SomeExceptionClass - код выполнится при ошибке определённого класса.'.red
rescue SomeOtherException => some_other_variable
  puts 'SomeOtherException - код выполнится при ошибке определённого класса.'.red
else
  puts 'else - код выполнится если блок begin выполненился без ошибок.'.green
ensure
  puts 'ensure - код выполнится и в случае ошибки и без неё.'.blue
end
