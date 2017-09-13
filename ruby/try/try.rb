# encoding: UTF-8

# Не ловите все ошибки! иначе вы их не увидите а они будут, не делайте так:
# 
# begin
#   ...
# rescue Exception => e
#    puts e.message
# end
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
