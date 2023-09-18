
```rb
# config/routes.rb
  match "/404", to: "admin/errors#not_found", via: :all
  match "/500", to: "admin/errors#internal_server_error", via: :all
# config/application.rb
    # config.exceptions_app = self.routes
    config.exceptions_app = lambda do |env|
      Admin::ErrorsController.action(:render_error).call(env)
    end
# app/controllers/admin/errors_controller.rb
class Admin::ErrorsController < Admin::ApplicationController
  def not_found
    render status: 404
  end

  def internal_server_error
    render status: 500
  end

  def render_error
    debugger
  end
end
```
