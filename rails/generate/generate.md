
## Настройки генератора

_config/application.rb_

```ruby
    config.generators.jbuilder = false
    # или
    config.generators do |g|
      g.template_engine   :erb
      g.assets            false
      g.helper            false
      g.test_framework    nil
      g.jbuilder          false
    end
```

```bash
# Список доступных генераторов ;)
TASKER=1 bundle exec rails g

# Миграции
rails g migration AddColumnNameColumnToTableName deleted_at:datetime
rails g migration add_hidden_column_to_posts hidden:boolean

# Контроллер
bundle exec rails g controller catalog index --no-test-framework --no-helper --no-javascripts --no-stylesheets --no-assets
bundle exec rails g scaffold_controller catalog_order --no-test-framework --no-helper --no-javascripts --no-jbuilder --no-stylesheets
bundle exec rails g scaffold_controller admin/affiliate --no-test-framework --no-jbuilder
# для АПИ API
docker compose exec web bundle exec rails g --help
docker compose exec web bundle exec rails g controller --help
docker compose exec web bundle exec rails g controller api/v1/application_settings --no-assets --no-javascripts --no-stylesheets --no-template-engine --no-request-specs --no-controller-specs --no-view-specs --no-routing-specs --no-helper-specs

# Модель
bundle exec rails g model street --no-test-framework --skip-migration
bundle exec rails g model admin/model/setting key:string:uniq value:string --no-test-framework

# Всё
bundle exec rails g scaffold filter name:string:uniq slug:string:uniq value_type:integer --no-stylesheets --no-assets --no-timestamps --no-helper --no-javascripts --no-test-framework

# Задачи
rails g task tasks_namespace task1 task2

# Аплоадер (гем carrierwave)
bundle exec rails g uploader ProductImages
```
