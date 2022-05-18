#!/usr/bin/env ruby

require 'active_support/all'
require 'awesome_print'
require 'redis'

# Расспаралеливание в потоки (для Redis соединения). Не путать с кластеризацией Redis!
require 'connection_pool'

# Распаралеллим в потоки с помощью гема connection_pool
# P.S.:
# Не путать кластеризацию (https://github.com/redis/redis-rb#cluster-support)
# с распаралеливанием в потоки (https://www.mayerdan.com/ruby/2022/03/26/ruby-redis)
pool_size = ENV.fetch("RAILS_MAX_THREADS", 10)
REDIS_POOL = ConnectionPool.new(size: pool_size) do
  Redis.new(
    url: ENV.fetch('REDIS_URL', 'redis://localhost:6379/0'),
    timeout: ENV.fetch("REDIS_TIMEOUT", 1),
    reconnect_attempts: ENV.fetch("REDIS_RECONNECT_ATTEMPTS", 3),
    reconnect_delay: ENV.fetch("REDIS_RECONNECT_DELAY", 0.5),
    reconnect_delay_max: ENV.fetch("REDIS_RECONNECT_DELAY_MAX", 5)
  )
end
# Использование Redis:
REDIS_POOL.with do |conn|
  puts conn.set(:a, 111)
  puts conn.get(:a)
end
# exit

# Простое однопоточное соединение с Redis
$r = Redis.new(
  url: ENV.fetch('REDIS_URL', 'redis://localhost:6379/0'),
  timeout: ENV.fetch('REDIS_TIMEOUT', 1),
  reconnect_attempts: ENV.fetch('REDIS_RECONNECT_ATTEMPTS', 3),
  reconnect_delay: ENV.fetch('REDIS_RECONNECT_DELAY', 0.5),
  reconnect_delay_max: ENV.fetch('REDIS_RECONNECT_DELAY_MAX', 5)
)

puts 'Запись'.green
a = $r.set('a', 'a')
print 'a: '.red; puts a
# exit 0

puts 'Чтение'.green
a = $r.get('a')
print 'a: '.red; puts a
# exit 0

puts 'Инкримент incr decr incrby decrby'.green
a = $r.set('a', 1)
b = $r.incr('a')
c = $r.get('a')
print 'a: '.red; puts a
print 'b: '.red; puts b
print 'c: '.red; puts c
a = $r.set('a', 0)
b = $r.set('b', 0)
c = $r.incr("a")
d = $r.decr("b")
e = $r.incrby("a", 99)
f = $r.decrby("b", -101)
print 'a: '.red; puts a
print 'b: '.red; puts b
print 'c: '.red; puts c
print 'd: '.red; puts d
print 'e: '.red; puts e
print 'f: '.red; puts f
# exit 0

puts 'Удаление'.green
a = $r.set('a', 1)
b = $r.del('a')
c = $r.get('a')
print 'a: '.red; puts a
print 'b: '.red; puts b
print 'c: '.red; puts c
# exit 0

puts 'Хранение хэш'.green
a = $r.hset('c', 'asd', 1)
b = $r.hset('c', 'zxc', 2)
c = $r.hget('c', 'asd')
d = $r.hmset('c', 'qwe', 3, 'asd', 4)
e = $r.hvals('c')
f = $r.hlen('c')
print 'a: '.red; puts a
print 'b: '.red; puts b
print 'c: '.red; puts c
print 'd: '.red; puts d
print 'e: '.red; p e
print 'f: '.red; puts f
# exit 0

puts 'Отсортированные наборы'.green
puts 'добвляем в набор'.blue
a = $r.zadd('a', 10, 'val10')
b = $r.zadd('a', 20, 'val20')
c = $r.zadd('a', 30, 'val30')
print 'a: '.red; puts a
print 'b: '.red; puts b
print 'c: '.red; puts c
puts 'zrange(ключ, , сколько элементов выбрать) - выбрать по возрастанию'.blue
d = $r.zrange('a', 0, 0)
e = $r.zrange('a', 0, 1)
f = $r.zrange('a', 0, -1)
print 'd: '.red; puts d
print 'e: '.red; p e
print 'f: '.red; p f
puts 'zrange(ключ, с какого элемента из выбранных начать вывод, сколько элементов выбрать) - выбрать по возрастанию'.blue
d = $r.zrange('a', 0, -1)
e = $r.zrange('a', 1, -1)
f = $r.zrange('a', 2, -1)
print 'd: '.red; p d
print 'e: '.red; p e
print 'f: '.red; p f
puts 'zrevrange(ключ, с какого элемента из выбранных начать вывод, сколько элементов выбрать) - выбрать по убыванию'.blue
d = $r.zrevrange('a', 0, -1)
e = $r.zrevrange('a', 1, -1)
f = $r.zrevrange('a', 2, -1)
print 'd: '.red; p d
print 'e: '.red; p e
print 'f: '.red; p f
# exit 0

puts 'Время жизни'.green
puts 'expire - задать количество секунд - сколько ещё прожить'.blue
a = $r.set('a', 1)
b = $r.expire('a', 2)
c = $r.get('a')
print 'a: '.red; puts a
print 'b: '.red; puts b
print 'c: '.red; puts c
sleep(2)
c = $r.get('a')
print 'c: '.red; puts c
puts 'expireat - задать время окончания - до какого времени прожить'.blue
a = $r.set('a', 1)
b = $r.expireat('a', Time.current.to_i + 2)
c = $r.get('a')
print 'a: '.red; puts a
print 'b: '.red; puts b
print 'c: '.red; puts c
sleep(2)
c = $r.get('a')
print 'c: '.red; puts c
# exit 0
