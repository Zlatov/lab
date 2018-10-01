# encoding: UTF-8
require 'awesome_print'

puts
puts '` - Возвращает результат команды оболочки'.green
a = 'echo "hi"'
b = `echo 'hi'`
c = `#{a}`
print 'a: '.red; puts a
print 'b: '.red; puts b
print 'c: '.red; puts c

puts
puts '%x - Возвращает результат команды оболочки'.green
b = %x( echo 'hi' )
c = %x[ #{a} ]
print 'b: '.red; puts b
print 'c: '.red; puts c

puts
puts 'system - Возвращает булево значение успешного выполения'.green
b = system( "echo 'hi'" )
c = system( a )
print 'b: '.red; puts b
print 'c: '.red; puts c

puts
puts 'exec - Возвращает none, прерывает выполнение'.green
# exec( "echo 'hi'" )
# exec( a )

# a = `ssh user@host.newstar.ru ls ./`
# puts system('rm -rf data')
# puts system('if [ ! -d "data" ]; then mkdir data; fi')
# puts system('scp user@host.newstar.ru:~/_ZENONLINE/cgi-bin/articles/text/* ./data')
# puts data_folder_exist = ((`if [ -d "data" ]; then echo -n '1'; else echo -n '0'; fi` == '1') ? true : false)
