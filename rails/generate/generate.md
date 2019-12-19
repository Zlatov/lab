
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
rails g scaffold_controller catalog_order --no-test-framework --no-helper --no-javascripts --no-jbuilder
rails g model street --no-test-framework --skip-migration
```
