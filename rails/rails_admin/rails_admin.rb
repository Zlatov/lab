
# ...

require Rails.root.join('lib', 'rails_admin', 'orders_analysis.rb')

RailsAdmin.config do |config|
  RailsAdmin::Config::Actions.register(RailsAdmin::Config::Actions::OrdersAnalysis)

  # ...

  config.actions do
    orders_analysis do
      only 'Market::Model::Order'
    end
  end
end
