#!/usr/bin/env ruby
require 'active_record'
require 'awesome_print'

ActiveRecord::Base.establish_connection({
  adapter: 'postgresql',
  encoding: 'unicode',
  database: 'lab',
  pool: 5,
  timeout: 5000,
  user: 'lab',
  password: 'lab'
})

ActiveRecord::Schema.define(version: 2018_12_27_085937) do

  enable_extension "plpgsql"

  create_table "posts", force: :cascade do |t|
    t.string "header", null: false
    t.string "slug", null: false
    t.text   "content"
    t.string "title"
    t.string "description"
    t.string "keywords"
    t.index ["header"], unique: true
    t.index ["slug"], unique: true
  end
end

class Post < ActiveRecord::Base
end

a = Post.all
print 'a: '.red; p a

a = Post.new header: 'a', slug: 'a'
a.save!
print 'a: '.red; p a

a = Post.all
print 'a: '.red; p a
