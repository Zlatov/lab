1. Создать файл _lib/tasks/db/seed.rake_:

```ruby
namespace :db do
namespace :seed do


# 
# Этот файл автоматически создаёт задачи по типу `rails db:seed:<task_name>`
# где task_name - имя файлов в папкет проекта db/seed/*.rb
# 
# Например, нужно загрузить демонстрационные данные, для staging-сервера:
# ```
# rails db:seed:staging
# ```
# 
# Такие задачи (соответственно загрузка данных) должны быть __Идемпотентны__, то есть
# при выполнении задачи множество раз не должно возникать никаких ошибок, а результат
# должен быть одинаков - загрузка данных, или, если объекты уже есть - обновление объекта
# до заданного демонстрационного состояния.
# 
# Чтобы просмотреть все задачи (типы демонстрационных данных), выполните команду:
# ```
# bundle exec rails -P | grep db:seed
# ```
# 
Dir[File.join(Rails.root, 'db', 'seed', '*.rb')].each do |filename|
  task_name = File.basename(filename, '.rb').intern
  task task_name => :environment do
    load(filename)
  end
end

# 
# Выполнить все файлы в db/seed/*.rb
# rails db:seed:all
task :all => :environment do
  puts "Запрещено".red
  exit 1
  Dir[File.join(Rails.root, 'db', 'seed', '*.rb')].sort.each do |filename|
    load(filename)
  end
end


end
end

```

2. Создать файл _db/seed/staging.rb_:

```ruby
# 
# Этот файл создан для загрузки демонстрационных данных "staging"
# для более подробной информации прочитайте файл _lib/tasks/db/seed.rake_
# 
# Запуск этого файла: `RAILS_ENV=development bundle exec rails db:seed:staging`
# 

puts 'catalogs:'.green
YAML::load_file(Rails.root.join('db', 'seed', 'staging', 'catalogs.yml')).each do |record|
  search_hash = {id: record['id']}
  update_hash = record
  record = Catalog.where(search_hash).first_or_initialize
  record.update!(update_hash)
  print "#{record['id']} "
end
ActiveRecord::Base.connection.reset_pk_sequence!(:catalogs)
puts

puts 'products:'.green
YAML::load_file(Rails.root.join('db', 'seed', 'staging', 'products.yml')).each do |record|
  search_hash = {id: record['id']}
  update_hash = record
  record = Product.where(search_hash).first_or_initialize
  record.update!(update_hash)
  print "#{record['id']} "
end
ActiveRecord::Base.connection.reset_pk_sequence!(:products)
puts

puts 'catalog_products:'.green
YAML::load_file(Rails.root.join('db', 'seed', 'staging', 'catalog_products.yml')).each do |record|
  catalog = Catalog.find(record['catalog_id'])
  if !catalog.product_ids.include?(record['product_id'])
    catalog.products << Product.find(record['product_id'])
    print [record['catalog_id'], record['product_id']]
  end
end
puts

```

3. Пример Yaml файла _db/seed/staging/products.yml_:

```json
---
- id: 1
  name: Газовый котел Viessmann Vitopend 100-W A1JB (24 кВт)
  article: "000000001"
  price: 43690.00
  active: true
  garbage: false
  product_property: null
  discount: null
  filters: {"shirina": 50, "visota": 120.12}
- id: 2
  name: Водонагреватель Electrolux GWH 10 High Performance ECO
  article: "000000002"
  price: 9990
  active: true
  garbage: false
  product_property: null
  discount: 8190
  filters: {"shirina": 50.312, "visota": 120, "cvet": "Зелёный"}

```
