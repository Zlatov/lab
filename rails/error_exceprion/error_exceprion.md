## Какие ошибки следует отлавливать

```rb
# Не делать так:
begin
  …
rescue => e
  …
end
# Тут спасаются ошибки всех классов унаследованных от Exception, даже
# SignalException, SyntaxError…

# Делать так:
begin
  …
rescue StandardError => e
  …
end
```


## Как в development режиме просматривать ошибки как в production

```rb
# config/environments/development.rb

# Show full error reports.
# config.consider_all_requests_local = true
config.consider_all_requests_local = ENV.fetch('SHOW_ERRORS_LIKE_IN_PRODUCTION_MODE'){nil}.present? ? false : true

# variables.env
# Переменная влияет только на режим development. Оставте пустое значение или
# закомментируйте если не хотите видеть производственные ошибки. Используется
# для отладки страниц ошибок при разработке (иначе выдается страница с ошибкой
# и стэком вызовов)
SHOW_ERRORS_LIKE_IN_PRODUCTION_MODE=1
# SHOW_ERRORS_LIKE_IN_PRODUCTION_MODE=
```


## Отловить неотловленные ошибки и показать страницу 500

```rb
# app/controllers/admin/application_controller.rb

rescue_from ..., with: :...
rescue_from ..., with: :...
rescue_from StandardError, with: :any_uncaught_errors

private

def any_uncaught_errors(exception)
  logger.error ([exception.message] + exception.backtrace).join("\n")
  respond_to do |format|
    format.html do
      if request.referer.present?
        flash[:danger] = exception.message
        redirect_back(fallback_location: root_path)
      else
        @exception = exception
        render 'admin/500', layout: 'admin/error', status: :internal_server_error and return
      end
    end
    format.json do
      render json: [exception.message], status: :internal_server_error
    end
  end
end

```
