
get "lorem/grid"

get "lorem/grid" => "lorem#grid"

get "lorem/grid" => "lorem#grid", as: "lorem_grid"

scope module: "market/desktop/vision" do
  get "lorem/grid"
end

if Rails.env.development?
  get "lorem/grid"
end

match "lorem/grid", via: [:get, :post]