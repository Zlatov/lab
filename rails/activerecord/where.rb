require 'rubygems'
require 'awesome_print'
require 'active_record'
require 'standalone_migrations'

ActiveRecord::Base.establish_connection \
  adapter: "postgresql",
  encoding: "unicode",
  database: "lab",
  pool: 5,
  timeout: 5000,
  user: "lab",
  password: "lab"

class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    connection.execute 'drop table if exists posts'
    create_table :posts do |t|
      t.string :header
      t.index [:header], name: "ix_posts_header", unique: true
    end
  end
end
CreatePosts.new.change

class Post < ActiveRecord::Base
end

Post.new(header: "1").save
Post.new(header: "2").save

puts Post.where(header:"2").first.header

puts 'asd'.green
