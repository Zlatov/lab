# encoding: UTF-8
def meth param
  p param
end

def meth2 *param
  p param
end

def options_merge options={}
  def_options = {a:'a',b:'b'}
  res_options = def_options.merge(options)
  p res_options
end

# meth 'asd'

# meth2 'asd'
# meth2 'asd', 'zxc'

meth ({asd:'zxc',:qwe => 'asd'})
meth({asd:'zxc',:qwe => 'asd'})
meth :asd => 'zxc'
meth asd: 'zxc', zxc: ['asd','zxc']

meth2 asd: 'zxc', zxc: ['asd','zxc']

options_merge
options_merge c:'cc'
options_merge a:'aa', c:'cc'
