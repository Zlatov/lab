...

# От гема dotenv
require 'dotenv'
Dotenv.load('variables.env')

module Admin
  class Application < Rails::Application

    # autoload_paths подгружает Классы, но в продакшн режиме всёравно подгружает
    # только после первого обращения в коде к Классу, для прогрузки Классов при
    # старте приложения необходимо использовать eager_load_paths
    config.autoload_paths += Dir["#{config.root}/lib/extensions/**/"]
    config.autoload_paths << Rails.root.join('lib/extensions')
    config.autoload_paths << "#{config.root}/app/services"
    config.eager_load_paths << "#{config.root}/app/services"
