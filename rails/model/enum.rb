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
    t.integer "status", null: false, default: 2
  end
end

# ActiveRecord::Base.connection.reset_pk_sequence!(:posts)

class Post < ActiveRecord::Base
  enum status: {one: 1, two: 2, done: 4}
end

a = Post.all
print 'a: '.red; p a

Post.create! status: 'one'
Post.create! status: 1
Post.create! status: 4
Post.create! status: 'done'

Post.all.each do |post|
  print 'post: '.red; p post
  print 'post.read_attribute_before_type_cast(:status): '.red; puts post.read_attribute_before_type_cast(:status)
end

puts Post.find(1).one?
