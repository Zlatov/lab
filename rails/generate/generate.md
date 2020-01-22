
_config/application.rb_
```ruby
    config.generators.jbuilder = false
    # or
    config.generators do |g|
      g.template_engine   :erb
      g.assets            false
      g.helper            false
      g.test_framework    nil
      g.jbuilder          false
    end
```

```bash
bundle exec rails g controller catalog index --no-test-framework --no-helper --no-javascripts --no-stylesheets --no-assets
bundle exec rails g scaffold_controller catalog_order --no-test-framework --no-helper --no-javascripts --no-jbuilder --no-stylesheets
bundle exec rails g model street --no-test-framework --skip-migration

rails g scaffold filter name:string:uniq slug:string:uniq value_type:integer --no-stylesheets --no-assets --no-timestamps --no-helper --no-javascripts --no-test-framework
```
