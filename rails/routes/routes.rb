
# 
# http://localhost:3000/rails/info/routes
# `$ rails routes` - список всех путей;
# `$ rails routes | grep account` - список путей которые содержат ...;
# `$ rails routes -c admin/users` - список путей контроллера;
# `> app.products_path` - проверка пути, вернёт url относительно домена;
# `> app.product_path 123` - -//-
# `> app.products_url` - проверка пути, вернёт Абсолютный url (с http).
# 


  # 
  # Общий случай
  # 

  get "lorem/grid"
  get "lorem/grid" => "lorem#grid"
  # Сразу как :id добавлено не формируется автоматический строковый идентификатор пути,
  # поэтому добавляем as: '...'
  get "lorem/grid/:id" => "lorem#grid", as: "lorem_grid"


  # 
  # Уточнения
  # 

# # 
# # _config/initializers/routing.rb_
# # 
# class DesktopDevice
#   def self.matches?(request)
#     # !Browser.new(request.user_agent).device.mobile?
#     true
#   end
# end
  # 
  # _config/routes.rb_
  # 
  constraints DesktopDevice do
    scope module: "market/desktop/vision" do
      get '/users/undeleteds/confirm/:hash' => 'undeleteds#confirm', as: :confirm_undeleted
      resources :undeleteds, path: '/users/undeleteds', only: [:new, :create]
      resources :c1_amounts, except: [:new, :create]
    end
  end

  # Появление путей в зависимости от энвиронмента
  if Rails.env.development?
    get "lorem/grid"
  end

  # Возможные методы запросы для маршрута
  match "lorem/grid", via: [:get, :post]

# В контроллере проверка текущего пути (только для GET запросов).
current_page?(account_order_history_path(@client.id))
