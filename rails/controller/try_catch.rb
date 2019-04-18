# 
# 1. Словим и обработаем все предопределённые исключения брошенные в действиях контроллера
# 
class ApplicationController < ActionController::Base
  rescue_from User::NotAuthorized, with: :deny_access
  rescue_from ActiveRecord::RecordInvalid, with: :show_errors

  rescue_from 'MyAppError::Base' do |exception|
    render xml: exception, status: 500
  end

  private

  def deny_access
    ...
  end

  def show_errors(exception)
    exception.record.new_record? ? ...
  end
end

# 
# 2. rescue_with_handler(exception, object: self, visited_exceptions: [])
# 
# Повидимому, этот метод позволяет определить будет ли словлено данное исключения контроллером
# Если будет словлено (или уже словлено), тонгда возвращается само исключение и мы можем с ним что-то делать еще.
# Если не будет словлено, возвращается нил, тогда обязательно нужно его пробросить далее,
# чтобы не иметь дело с неотловленными исключениями!
# 

begin
  …
rescue => exception
  rescue_with_handler(exception) || raise
end

# Возвращает исключение, если оно было обработано, а nil если нет.
