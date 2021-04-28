# START Копировать в новый файл лаборатории
require 'awesome_print'
require 'active_record'
require 'active_support/all'

ActiveRecord::Base.establish_connection \
  adapter: "postgresql",
  encoding: "unicode",
  database: "lab",
  pool: 5,
  timeout: 5000,
  user: "lab",
  password: "lab"

# с изменениями:
class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    connection.execute 'drop table if exists posts'
    create_table :posts do |t|
      t.string  :header,  null: false
      t.boolean :visible, null: false, default: false
      t.index [:header]
      t.index [:visible]
    end
  end
end
CreatePosts.new.change

class Post < ActiveRecord::Base
end

Post.new(header: "1", visible: false).save
Post.new(header: "2", visible: true).save
Post.new(header: "3", visible: true).save
# FINISH Копировать в новый файл лаборатории


# exec_delete(sql, name = nil, binds = [])
# Executes delete sql statement in the context of this connection using binds as
# the bind substitutes. name is logged along with the executed sql statement.

# exec_insert(sql, name = nil, binds = [], pk = nil, sequence_name = nil)
# Executes insert sql statement in the context of this connection using binds as
# the bind substitutes. name is logged along with the executed sql statement.

# exec_query(sql, name = "SQL", binds = [], prepare: false) Executes sql
# statement in the context of this connection using binds as the bind substitutes.
# name is logged along with the executed sql statement.
puts '.exec_query'.green
a = Post.connection.exec_query <<-SQL
  SELECT *
  FROM #{Post.table_name}
SQL
print 'a: '.red; p a
print 'a.columns: '.red; p a.columns
print 'a.rows: '.red; p a.rows
print 'a.to_hash: '.red; p a.to_hash
a.each do |row|
  print 'row: '.red; p row
  print 'row: '.red; p row['id']
end
b = a.pluck 'id'
print 'b: '.red; p b
# exit

# exec_update(sql, name = nil, binds = []) Executes update sql statement in
# the context of this connection using binds as the bind substitutes. name is
# logged along with the executed sql statement.
puts '.exec_update'.green
a = Post.connection.exec_update <<-SQL
  UPDATE #{Post.table_name}
  SET header = '111'
  WHERE id >= 2
SQL
print 'a: '.red; puts a
pp Post.all.to_a
# affected_rows

# execute(sql, name = nil) Executes the SQL statement in the context of this
# connection and returns the raw result from the connection adapter. Note:
# depending on your database connector, the result returned by this method may be
# manually memory managed. Consider using the exec_query wrapper instead.
puts '.execute'.green

a = Post.connection.execute <<-SQL
  SELECT *
  FROM #{Post.table_name}
SQL
print 'a: '.red; puts a
