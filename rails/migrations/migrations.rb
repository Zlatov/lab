
change_column :table_name, :column_name, :column_type, null: false, default: ''

remove_column :table_name, :column_name

drop_table :market_product_clips, if_exists: true

create_table "market_angars", force: :cascade do |t|
  t.string   "name"
  t.string   "address"
  t.integer  "stages"
  t.datetime "created_at", null: false
  t.datetime "updated_at", null: false
  t.float    "lat"
  t.float    "lng"
  t.index ["name"], name: "index_market_angars_on_name", unique: true
end

create_table :market_product_clips, id: :string, force: :cascade do |t|
  t.string :tab_id, null: false
  t.string :name,   null: false
  t.string :url
  t.text   :text

  t.index [:id], name: :uqix_marketproductclips_id, unique: true
  t.index [:tab_id], name: :ix_marketproductclips_tab_id
end

# Removes the index_accounts_on_column in the accounts table.
remove_index :accounts, :column
# Removes the index named index_accounts_on_branch_id in the accounts table.
remove_index :accounts, column: :branch_id
# Removes the index named index_accounts_on_branch_id_and_party_id in the accounts table.
remove_index :accounts, column: [:branch_id, :party_id]
# Removes the index named by_branch_party in the accounts table.
remove_index :accounts, name: :by_branch_party

# 
# add_index(table_name, column_name, options = {}) public
# add_index(table_name, [column_name, column_name2], options = {}) public
# Options: `unique: true, name: 'by_branch_party', length: 10`
# Options: `unique: true, name: 'by_branch_party', length: 10`
# ```
# add_index(:accounts, [:name, :surname], name: 'by_name_surname', length: {name: 10, surname: 15})
# ```
# Note: SQLite doesn’t support index length.
# 
add_index :table_name, :column_name, name: :uq_tablename_columnname, unique: true

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
