# encoding: UTF-8
require_relative '../colorize/colorize'
require 'rubygems'
require 'awesome_print'
require 'active_hash'

class Countries < ActiveHash::Base
  self.data = [
    {:id => 1, :name => "US"},
    {:id => 2, :name => "Canada"}
  ]
end

a = Countries.find 1
print 'a.name: '.red; puts a.name


class Article < ActiveHash::Base
  field :name
end

a = Article.new name: 'asd'
print 'a.name: '.red; puts a.name


class News < ActiveHash::Base
  field :name
  create :id => 1, :name => "US"
  create :id => 2, :name => "Canada"
end

a = News.find 2
print 'a.name: '.red; puts a.name
c = News.new id: 3, name: 'zxc'
c.save
b = News.find 3
print 'b.name: '.red; puts b.name
