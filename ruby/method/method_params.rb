# encoding: UTF-8
require_relative '../colorize/colorize'

a = 0
# `a = 1 if !a.is_a? String && a == 0` - ошибка, параметр должен быть в скобках.
a = 1 if !a.is_a? String # - а так кможно.
puts a

def meth1 param
  p param
  # p *param
end

# Все параметры собрать в массив, если параметров нет тогда массив пустой.
def meth2 *param
  p param
end

def meth3 id: 'default_id', pid: 'default_pid'
  print 'id: '.red; puts id
  p id
  p pid
  # p method(__method__).parameters
  # args = method(__method__).parameters.map { |arg| arg[1] }
  args = method(__method__).parameters.map do |_, name|
    binding.local_variable_get(name)
  end
  args_hash = Hash[ method(__method__).parameters.map {|_, name|
    [name, binding.local_variable_get(name)]
  }]
  p args
  p args_hash
  # p *args
  meth1 args_hash
end

def options_merge options={}
  def_options = {a:'a',b:'b'}
  res_options = def_options.merge(options)
  p res_options
end

# meth 'asd'

# meth2 'asd'
# meth2 'asd', 'zxc'

puts 'meth1 передаём Hash'.green
meth1 ({asd:'zxc',:qwe => 'asd'})
meth1({asd:'zxc',:qwe => 'asd'})
meth1 :asd => 'zxc'
meth1 asd: 'zxc', zxc: ['asd','zxc']

puts 'meth2 передаём Hash'.green
meth2 asd: 'zxc', zxc: ['asd','zxc']

puts 'meth2 передаём Параметры'.green
meth2 :video, :suka
# exit

puts 'options_merge передаём Hash'.green
options_merge
options_merge c:'cc'
options_merge a:'aa', c:'cc'

puts 'meth3 передаём Hash'.green
meth3 pid: 'custom_pid'

