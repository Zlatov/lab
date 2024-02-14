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
# Таблицы
# 

drop_table :market_product_clips, if_exists: true

class CreateLorems < ActiveRecord::Migration[7.1]
  def change
    create_table :lorems, id: :string, primary_key: :code do |t|
      t.string   :name, null: false
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

      t.timestamps
      # ИЛИ
      t.datetime "created_at"
      t.datetime "updated_at"

      t.index :updated_at, name: :ix_lorems_updatedat
    end
  end
end
add_index :lorem, :name, unique: true

create_table :market_product_clips, id: :string, force: :cascade do |t|
  t.string :tab_id, null: false
  t.string :name,   null: false
  t.string :url
  t.index [:id], name: :uqix_marketproductclips_id, unique: true
  t.index [:tab_id], name: :ix_marketproductclips_tab_id
end
# Таблица много ко многим.
# Индексы по умолчанию не создаются, а обычно они нужны, поэтому так. По
# умолчанию NOT NULL поэтому в миграции не указано ничего. Если нужно создать
# много ко многим с NULL то необходимо добавить параметр table_name,
# table_name, column_options: { null: true }
create_join_table :tags, :posts do |t|
  t.index :post_id
  t.index :tag_id
end




# 
# has_and_belongs_to_many
# 

# `rails g migration CreateJoinTableAffiliatesArticles affiliate article`
    create_join_table :affiliates, :articles do |t|
      t.index [:affiliate_id, :article_id], unique: true, name: "uq_affiliates_articles_affiliateidarticleid"
      # t.index [:article_id, :affiliate_id]
    end
    add_foreign_key :affiliates_articles, :affiliates, on_update: :cascade, on_delete: :cascade
    add_foreign_key :affiliates_articles, :articles, on_update: :cascade, on_delete: :cascade

    # Кастомная таблица связей (при создании второй связи к той-же таблице)
    create_table "market_offers_product_affiliates", id: false, force: :cascade do |t|
      t.integer "affiliate_id", null: false
      t.integer "offer_id", null: false
      t.index "affiliate_id", name: "ix_market_offers_product_affiliates_affiliateid"
      t.index "offer_id", name: "uq_market_offers_product_affiliates_offerid"
      t.index ["affiliate_id", "offer_id"], name: "uq_market_offers_product_affiliates_ids", unique: true
    end
    add_foreign_key :market_offers_product_affiliates, :market_affiliates,
      primary_key: :id,
      column: "affiliate_id",
      on_update: :cascade,
      on_delete: :cascade
    add_foreign_key :market_offers_product_affiliates, :market_offers,
      primary_key: :id,
      column: "offer_id",
      on_update: :cascade,
      on_delete: :cascade




# 
# Колонки
# 

# 
# Добавление колонок
# 

rails g migration add_column_name_to_table_name column_name:string|text|integer|bigint|boolean|float|decimal|datetime|date|jsonb
add_column :table_name, :column_name, :string|text|integer|bigint|boolean|float|decimal|datetime|date|jsonb, null: false, default: 0, limit: 1(lenght|bytes), precision: 10(всего), scale: 2(после запятой), comment: ''
add_column :table_name, :column_name, :string,
  :null => false # Allows or disallows NULL values in the column.
  :default => nil # The column’s default value. Use nil for NULL.
  :limit => 256 # Requests a maximum column length. This is the number of characters for a :string column and number of bytes for :text, :binary and :integer columns. This option is ignored by some backends.
  :precision => 10 # (Сколько всего знаков!) Specifies the precision for the :decimal and :numeric columns.
  :scale => 2 # (Сколько знаков после запятой!) Specifies the scale for the :decimal and :numeric columns.
  :comment => '...' # Specifies the comment for the column. This option is ignored by some backends.

# Опция :limit
:limit     | Numeric Type | Column Size | Max value
1          | tinyint      | 1 byte      | 127
2          | smallint     | 2 bytes     | 32767
3          | mediumint    | 3 byte      | 8388607
nil, 4, 11 | int(11)      | 4 byte      | 2147483647
5..8       | bigint       | 8 byte      | 9223372036854775807


# 
# Изменение колонки
# 

rails g migration 
change_column :table_name, :column_name, :type, null: false, default: '', comment: ''


# 
# Удаление колонки
# 

rails g migration RemoveFieldNameFromTableName field_name:datatype
remove_column :table_name, :column_name, :column_type_for_rollback, :options_for_rollback = {}

# Добавление колонки через указание связи, связь обязательная поэтому через три
# миграции: добавить необязательное поле, наполнить, изменить на обязательное.
  def up
    # кривые ключи поэтому закомментировано:
    # add_reference :market_offers, :market_affiliates
    add_reference :market_offers, :affiliate,
      foreign_key: { to_table: :market_affiliates, on_update: :cascade, on_delete: :cascade }
  end
  def down
    remove_reference :market_offers, :affiliate
  end

  def change
    ::Market::Model::Offer.update_all(affiliate_id: ::Market::Model::Affiliate.where(deleted: false).first.id)
  end

  def change
    change_column :market_offers, :affiliate_id, :bigint, null: false
  end




# 
# Внешние ключи
# 

# Какая печаль, что это всё ненужно, когда мы используем has_and_belongs_to_many
# Добавление FK при соществующей таблице и сущ-ем поле.
add_foreign_key :from_table, :to_table, column: "parent_id", primary_key: "id", name: "fk_folders_parentid", on_update: :cascade, on_delete: <:restrict|:nullify|:cascade>
add_foreign_key :folders, :folders, column: "parent_id", primary_key: "id", name: "fk_folders_parentid", on_update: :cascade, on_delete: :restrict
add_foreign_key :emails, :users, on_delete: :cascade, validate: false
# Удаление FK
remove_foreign_key_if_exists :emails, column: :user_id
# Поле и FK при создании таблицы
create_table ...
  ...
  t.references :market_order, index: true, foreign_key: {on_delete: :cascade}
end
# Поле и FK при существующей таблице
add_reference :table_name, "ref_name", foreign_key: true
add_reference :table_name, "ref_name", foreign_key: {on_update: :cascade, on_delete: <:restrict|:nullify|:cascade>}
add_reference :articles, "affiliate", foreign_key: {on_update: :cascade, on_delete: :nullify}




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
  # Порядок вызова методов гема относительно методов ActiveRecord (change/up/down):
  # def data_before
  # def change/up
  # def data/data_after
  # 
  # def rollback_before
  # def change/down
  # def rollback/rollback_after
  def data
    stack_path = Rails.root.join 'tmp', 'stack.json'
    stack_json = File.read stack_path
    stack = JSON.parse stack_json

    ArAt.reset_column_information
    ArAt.import stack
  end


# belongs_to
# Добавить связь belongs_to
# Свойства принадлежат Проектам -> в Свойства добавляем foreign key
rails g migration AddProjectToProperty project:belongs_to
# Сгенерирует:
add_reference :properties, :project, null: false, foreign_key: true
# Возможно меняем на:
add_reference :properties, :project, null: true, foreign_key: {on_update: :cascade, on_delete: <:restrict|:nullify|:cascade>}
# В модели:
belongs_to :project, optional: true
has_many :properties




# 
# Первичный ключ по нескольким полям
# 
create_table :prices, primary_key: [:product_code, :affiliate_code] do |t|
  t.string  :product_code, null: false
  t.string  :affiliate_code, null: false
  ...

  t.timestamps

  t.index :updated_at, name: :ix_prices_updatedat
  # Несмотря на то что первичный ключ указан, постгрес не создаёт явные индексы
  # для полей уникаьного ключа. Однако в документации указано, что при создании
  # любой уникальности автоматически создаются индексы, так как они
  # обеспечивают эту уникальность.
  # 
  # На сколько перегрузит лишними данными мою БД если я перестрахуюсь и добавлю
  # дополнительные индексы?
  t.index :product_code, name: 'ix_c1_prices_productcode'
  t.index :affiliate_code, name: 'ix_c1_prices_affiliatecode'
  # t.index [:product_code, :affiliate_code], name: 'uq_c1_prices_productcodeaffiliatecode', unique: true
end
# Это видимо когда я забыло убрать опцию id: false
execute 'ALTER TABLE prices ADD PRIMARY KEY (product_code, affiliate_code);'
# В моделях добавить:
# С гемом composite_primary_keys
# self.primary_keys = :code, :uuid
# Без гема composite_primary_keys
self.primary_key = [:code, :uuid]
