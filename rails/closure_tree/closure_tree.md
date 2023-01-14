# Closure Tree

```rb
# Gemfile
# Древовидная структура данных
gem "closure_tree"
```

```sh
bundle
```

```rb
# app/models/catalog.rb
class Catalog < ApplicationRecord
  has_closure_tree

# rails g migration closure_tree_catalog
add_column :tags, :parent_id, :integer
```

```sh
rails g closure_tree:migration catalog
rails db:migrate
```
