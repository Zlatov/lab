Модуль Api _app/controllers/concerns/api.rb_

```ruby
module Api

  extend ActiveSupport::Concern

  included do |base|

    before_action :set_headers

    base.class_eval do
      ActionController::Parameters.action_on_unpermitted_parameters = :raise

      rescue_from(ActionController::UnpermittedParameters) do |e|
        render json: {
          error:  {
            unknown_parameters: e.params
          }
        }, status: :bad_request
      end

      rescue_from(ActionController::ParameterMissing) do |e|
        render json: {
          error:  {
            missing_parameter: e.param
          }
        }, status: :bad_request
      end
    end
  end

  def set_headers
    response.headers["Cache-Control"] = "no-cache, no-store"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end

  module ClassMethods
  end
end

```

Контроллер

```ruby
class ApiExchangeController < ApplicationController

  include Api

  def order_pull
    order_pull_params
    render json: {}
  end

  def order_push
    render json: {}
  end

  private

  def order_pull_params
    params.require(:id)
    params.permit(:sid)
  end
end
```
