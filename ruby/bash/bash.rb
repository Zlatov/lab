# encoding: UTF-8
require 'awesome_print'

puts
puts '` - Возвращает результат команды оболочки'.green
a = "echo \"hi\""
b = `#{a}`
c = $?
d = c.exitstatus
print 'a: '.red; puts a
print 'b: '.red; puts b
print 'c: '.red; puts c
print 'd: '.red; puts d
# exit 0

puts
puts '%x - Возвращает результат команды оболочки'.green
a = "echo \"hi\""
b = %x(#{a})
c = $?
d = c.exitstatus
print 'a: '.red; puts a
print 'b: '.red; puts b
print 'c: '.red; puts c
print 'd: '.red; puts d
# exit 0

puts
puts 'system - Возвращает булево значение успешного выполения'.green
puts "подробнее: https://apidock.com/ruby/Kernel/system".blue
a = "echo \"hi\""
b = system( "echoc 'hi'" )
c = system( a )
d = system("[ -d data ] && exit 0 || exit 1")
print 'b: '.red; puts b
print 'c: '.red; puts c
print 'd: '.red; puts d
# exit

puts
puts "Установка дополнительных переменных окружения с system()".green
puts "подробнее: https://apidock.com/ruby/Kernel/spawn".blue
a = system({"MYVAR" => "42"}, "echo $MYVAR")
a = system({"MYVAR" => "42"}, "echo $MYVAR", :out=>["temp_log", "w"])
print 'STDOUT: '.red; print STDOUT; puts " Константа. Значение по умолчанию для $stdout.".blue
print '$stdout: '.red; print $stdout; puts " Текущий стандартный выход.".blue
a = system({"MYVAR" => "42"}, "echo $MYVAR", :out => STDOUT)
print 'a: '.red; puts a
a = system({"MYVAR" => "42"}, "/home/iadfeshchm/projects/my/lab/ruby/bash/bash")
print 'a: '.red; puts a
exit

system("bash", "-c", "echo я использую $0 и хрен тут что сделаешь?")
system({"MYVAR" => "42"}, "bash", "-c", "echo я использую $0 и хрен тут ${MYVAR}!", :out => STDOUT)
# exit

puts "Установка дополнительных переменных окружения с %x".green
s = %x(
echo я использую $0
MYVAR=43 ./bash
)
print 's: '.red; puts s
# exit

puts
puts 'exec - Возвращает none, прерывает выполнение'.green
# exec( "echo 'hi'" )
# exec( a )

# a = `ssh user@host.newstar.ru ls ./`
# puts system('rm -rf data')
# puts system('if [ ! -d "data" ]; then mkdir data; fi')
# puts system('scp user@host.newstar.ru:~/_ZENONLINE/cgi-bin/articles/text/* ./data')
# puts data_folder_exist = ((`if [ -d "data" ]; then echo -n '1'; else echo -n '0'; fi` == '1') ? true : false)
