require 'rubygems'
require 'awesome_print'
require 'active_record'
require 'standalone_migrations'
require 'date'
require 'active_support/all'

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
      t.string  :header,  null: false
      t.date    :date
      t.boolean :visible, null: false, default: false
      t.index [:header], name: "ix_posts_header", unique: true
      t.index [:date], name: "ix_posts_date"
      t.index [:visible], name: "ix_posts_visible"
    end
  end
end
CreatePosts.new.change

class Post < ActiveRecord::Base
end

Post.new(header: "1", visible: false).save
Post.new(header: "2", visible: true, date: DateTime.new(2000,1,1)).save
Post.new(header: "3", visible: true, date: DateTime.new(2000,1,2)).save

# Если есть необходимость задавать условия как в хеш так и в строковом SQL:
a = Post.where("date >= '2000-01-01' AND date <= '2000-01-01'").where(visible: true)
puts a.to_sql
puts a.first.header

# 
# Includes использует нетерпеливую загрузку
# joins использует отложенную загрузку
# 
# Проблема joins в том что, при переборе полученных записей данные из связанных запросов будут получаться
# 
# references
# 
# StatR.includes(:date).where("admin_stat_dates.date = ?", '2019-01-20').references(:date).page(1).to_sql
# # SELECT
# #   "admin_stat_relays"."date_id" AS t0_r0,
# #   "admin_stat_relays"."email_id" AS t0_r1,
# #   "admin_stat_relays"."status_id" AS t0_r2,
# #   "admin_stat_relays"."label_id" AS t0_r3,
# #   "admin_stat_relays"."count" AS t0_r4,
# #   "admin_stat_dates"."id" AS t1_r0,
# #   "admin_stat_dates"."date" AS t1_r1
# # FROM "admin_stat_relays"
# # LEFT OUTER JOIN "admin_stat_dates" ON "admin_stat_dates"."id" = "admin_stat_relays"."date_id"
# # WHERE (admin_stat_dates.date = '2019-01-20') LIMIT 25 OFFSET 0

# StatR.includes(:date).where("admin_stat_dates.date" => '2019-01-20').page(1).to_sql
# # SELECT
# #   "admin_stat_relays"."date_id" AS t0_r0,
# #   "admin_stat_relays"."email_id" AS t0_r1,
# #   "admin_stat_relays"."status_id" AS t0_r2,
# #   "admin_stat_relays"."label_id" AS t0_r3,
# #   "admin_stat_relays"."count" AS t0_r4,
# #   "admin_stat_dates"."id" AS t1_r0,
# #   "admin_stat_dates"."date" AS t1_r1
# # FROM "admin_stat_relays"
# # LEFT OUTER JOIN "admin_stat_dates" ON "admin_stat_dates"."id" = "admin_stat_relays"."date_id"
# # WHERE "admin_stat_dates"."date" = '2019-01-20' LIMIT 25 OFFSET 0

puts 'Done.'.green
