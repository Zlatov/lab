# 
# Создание файла миграций
# 

# 
# `rails generate migration <migration_name>`
# `rails g migration AddColumnNameToTableName column_name:type`
# `rails db:migrate`
# `rails db:rollback`
# `rails db:migrate VERSION=20191029065940`
# 




# 
# Колонки
# 

change_column :table_name, :column_name, :column_type, null: false, default: ''
add_column table_name, column_name, type, options
add_column :table_name, "column_name", :string,
  null: true,
  limit: 256
# options
  :limit # Requests a maximum column length. This is the number of characters for a :string column and number of bytes for :text, :binary and :integer columns. This option is ignored by some backends.
  :default # The column’s default value. Use nil for NULL.
  :null # Allows or disallows NULL values in the column.
  :precision # Specifies the precision for the :decimal and :numeric columns.
  :scale # Specifies the scale for the :decimal and :numeric columns.
  :comment # Specifies the comment for the column. This option is ignored by some backends.

remove_column :table_name, :column_name




# 
# Таблицы
# 

drop_table :market_product_clips, if_exists: true

create_table "lorem", force: :cascade do |t|
  t.string   "name", null: true
  t.string   "address"
  t.integer  "stages"
  t.decimal  "price", precision: 10, scale: 2
  t.datetime "created_at", null: false
  t.datetime "updated_at", null: false
  t.float    "lat"
  t.float    "lng"
  t.text   :text
  t.index ["name"], name: "index_market_angars_on_name", unique: true
  # t.references :market_order, index: true, foreign_key: {on_delete: :cascade}
  # t.timestamps
  t.datetime "created_at"
  t.datetime "updated_at"
end
add_index :lorem, :name, unique: true

create_table :market_product_clips, id: :string, force: :cascade do |t|
  t.string :tab_id, null: false
  t.string :name,   null: false
  t.string :url
  t.index [:id], name: :uqix_marketproductclips_id, unique: true
  t.index [:tab_id], name: :ix_marketproductclips_tab_id
end




# 
# Внешние ключи
# 

add_foreign_key :from_table, :to_table, column: "parent_id", primary_key: "id", name: "fk_folders_parentid", on_update: :cascade, on_delete: :nullify
add_foreign_key :folders, :folders, column: "parent_id", primary_key: "id", name: "fk_folders_parentid", on_update: :cascade, on_delete: :restrict
# t.references :market_order, index: true, foreign_key: {on_delete: :cascade}
# add_reference :table_name, "ref_name", foreign_key: true




# 
# Индексы
# 

# Removes the index_accounts_on_column in the accounts table.
remove_index :accounts, :column
# Removes the index named index_accounts_on_branch_id in the accounts table.
remove_index :accounts, column: :branch_id
# Removes the index named index_accounts_on_branch_id_and_party_id in the accounts table.
remove_index :accounts, column: [:branch_id, :party_id]
# Removes the index named by_branch_party in the accounts table.
remove_index :accounts, name: :by_branch_party

add_index :table_name, "column_name", name: :uq_tablename_columnname, unique: true
# add_index(table_name, column_name, options = {}) public
# add_index(table_name, [column_name, column_name2], options = {}) public
# Options: `unique: true, name: 'by_branch_party', length: 10`
# Options: `unique: true, name: 'by_branch_party', length: 10`
# ```
# add_index(:accounts, [:name, :surname], name: 'by_name_surname', length: {name: 10, surname: 15})
# ```
# Note: SQLite doesn’t support index length.

gem "migration_data"
  def change
    stack = {}
    ArAt.all.each do |model|
      if !model.attachment.to_s.blank?
        stack[model.article_id] = model.attributes.to_h.merge "id" => model.article_id
      end
    end
    stack_json = stack.values.to_json
    stack_path = Rails.root.join 'tmp', 'stack.json'
    File.write stack_path, stack_json

    drop_table :market_article_attachments
    create_table "market_article_attachments" do |t|
      t.integer "article_id", null: false
      t.string  "attachment"
    end
  end
  def data
    stack_path = Rails.root.join 'tmp', 'stack.json'
    stack_json = File.read stack_path
    stack = JSON.parse stack_json

    ArAt.reset_column_information
    ArAt.import stack
  end
