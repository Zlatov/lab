# rswag

## Основные команды

```sh
rails generate rspec:swagger WorkshopsController
rake rswag:specs:swaggerize
```


## Пример с коментариями создания API

### 1. Создаём API контроллер и роуты

```sh
docker compose exec web bundle exec rails g controller --help
docker compose exec web bundle exec rails g controller api/v1/application_settings --no-assets --no-javascripts --no-stylesheets --no-template-engine --no-request-specs --no-controller-specs --no-view-specs --no-routing-specs --no-helper-specs
sudo chown -R $(id -u -n):$(id -u -n) ./app
```

```rb
# config/routes.rb
Rails.application.routes.draw do
  …
  namespace :api do
    namespace :v1 do
      …
      resource "application_settings", only: [:show]
    end
  end
end

# app/controllers/api/v1/application_settings_controller.rb
class Api::V1::ApplicationSettingsController < Api::BaseController
  def show
    render json: { name: 'asd', abbr: 'zxc' }, status: 200
  end
end
```

### 2. Создаём файл спецификации RSpec

Файла спецификации RSpec `spec/requests/api/v1/application_settings_spec.rb`
устанавливает требования к данным API контроллера (принимаемым и
возвращаемым).

```sh
docker compose exec web bundle exec rails generate rspec:swagger Api::V1::ApplicationSettingsController
sudo chown -R $(id -u -n):$(id -u -n) ./spec
```

Описываем API в файле спецификации RSpec;

```rb
# spec/requests/api/v1/application_settings_spec.rb
require 'swagger_helper'

RSpec.describe 'api/v1/application_settings', type: :request do
  path '/api/v1/application_settings' do
    get 'Текущие настройки приложения' do
      tags 'Настройки приложения'
      produces 'application/json'

      response 200, 'настройки найдены' do
        # Схема отдаваемых данных
        schema type: :object, description: ApplicationSetting.t, properties: {
          name: {type: :string, description: ApplicationSetting.human_attribute_name(:name)},
          abbr: {type: :string, description: ApplicationSetting.human_attribute_name(:abbr)}
        }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end

        # Проверить отдаваемые данные на соответствие схеме: swagger_strict_schema_validation: true
        run_test! swagger_strict_schema_validation: true
      end
    end
  end
end
```

### 3. Из спецификации RSpec создаём файл спецификации Swagger

Команда ниже компилирует файл `swagger/v1/swagger.yaml`.

```sh
docker compose exec web bundle exec rails rswag:specs:swaggerize
sudo chown -R $(id -u -n):$(id -u -n) ./swagger
```

[localhost:3001/api-docs](http://localhost:3001/api-docs)


### 4. Запуск теста

```sh
docker compose exec web bundle exec rspec ./spec/requests/api/v1/application_settings_spec.rb
```
