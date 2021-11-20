#!/usr/bin/env ruby
require 'active_record'
require 'awesome_print'
require 'activerecord-import'

ActiveRecord::Base.logger = ActiveSupport::Logger.new(STDOUT)

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

  drop_table :posts, if_exists: true
  create_table "posts" do |t|
    t.string "name", null: false
    t.string "slug"
    t.integer :status, null: false
  end
end

class Post < ActiveRecord::Base
end

def show_posts
  a = Post.all.to_a.map(&:as_json)
  print 'a: '.red; pp a
end

# Наполним начальными данными
a = [
  {name: 'asd', status: 1},
  {name: 'zxc', status: 2},
  {name: 'qwe', status: 3}
]
Post.import a

show_posts

# Обновим
full_data = [
  {id: 1, status: 3},
  {id: 2, status: 4},
  {id: 3, status: 5},
  {id: 4, status: 0}
]
# .transaction - исключаем ситуацию частичного обновления.
Post.transaction do
  # .each_slice - разбиваем на пакеты обновления.
  full_data.each_slice(2) do |data|
    hashed_data = Hash[data.map{|v| [v[:id], v]}]
    # Получаем только существующие посты
    posts = Post.where(id: hashed_data.keys)
    update_posts = []
    posts.each do |post|
      post.status = hashed_data[post.id][:status]
      update_posts << post
    end
    Post.import update_posts, on_duplicate_key_update: {conflict_target: [:id], columns: [:status]}
  end
end

show_posts
