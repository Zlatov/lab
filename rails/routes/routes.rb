
# 
# `$ rails routes` - список всех путей;
# `$ rails routes | grep account` - список путей которые содержат ...;
# `> app.products_path` - проверка пути, вернёт url относительно домена;
# `> app.product_path 123` - -//-
# `> app.products_url` - проверка пути, вернёт Абсолютный url (с http).
# 

get "lorem/grid"

get "lorem/grid" => "lorem#grid"

# Сразу как :id добавлено не формируется автоматический строковый идентификатор пути,
# поэтому добавляем as: '...'
get "lorem/grid/:id" => "lorem#grid", as: "lorem_grid"

scope module: "market/desktop/vision" do
  get "lorem/grid"
end

if Rails.env.development?
  get "lorem/grid"
end

match "lorem/grid", via: [:get, :post]
