# encoding: UTF-8
def meth param
  p param
end

def meth2 *param
  p param
end

# meth 'asd'

# meth2 'asd'
# meth2 'asd', 'zxc'

meth ({asd:'zxc',:qwe => 'asd'})
meth({asd:'zxc',:qwe => 'asd'})
meth :asd => 'zxc'
meth asd: 'zxc', zxc: ['asd','zxc']

