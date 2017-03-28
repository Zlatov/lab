require 'json'

a = '["a"]'
b = ['asd']
c = {asd:'asd'}

jb = b.to_json
jc = c.to_json

p jb
p jc

b = JSON.parse(jb)
c = JSON.parse(jc)

p b
p c

p hash