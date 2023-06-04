# Closure Tree

## Установка

```rb
# Добавить в файл Gemfile:
# Древовидная структура данных
gem "closure_tree"
```

```sh
# Установить гем
bundle install
```

```sh
# Проверить чтобы у модели была колонка parent_id, при необходимости добавить:
rails g migration closure_tree_catalog
add_column :catalogs, :parent_id, :bigint
add_index :catalogs, [:parent_id], name: :ix_catalogs_parentid
```

```rb
# Добавить в файл модели (app/models/catalog.rb) метод has_closure_tree
class Catalog < ApplicationRecord
  has_closure_tree
```

```sh
# Сгенерировать миграцию для содели гемом:
rails g closure_tree:migration catalog
rails db:migrate
```
