# encoding: UTF-8
require 'rubygems'
require 'awesome_print'

@a = ['1','2']
def slug_exists slug
  @a.include? slug
end
slug = '1'
new_slug = slug
i = 1

while slug_exists(new_slug)
  i+= 1
  new_slug = "#{slug}-#{i}"
end

print 'new_slug: '.red; puts new_slug
