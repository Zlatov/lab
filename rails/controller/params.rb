exit

# Метод .require
# Допустим такие параметры приходят:
params = ActionController::Parameters.new(user: { ... }, profile: { ... })
# Так нужно требовать что они (user и profile) обязательны и не пусты
# (нам нужен не просто наличие ключа, а данные в нём):
user_params, profile_params = params.require([:user, :profile])

  params.require(:post)
  # будет искать params[:post] и вызвать ошибку, если это не существует.
  params.permit(:name)
  # представляет список разрешенных (но необязательно) атрибутов.

  # Таким образом можно комбинировать методы двумя способами:
  # 
  # 1. когда параметры многоуровневые, например при генерации формой `form_for
  # (@post)`
  params.require(:post).permit(:name)
  # 2. когда параметры плоские и нужно воспользоваться обеими методами
  params.require(:slug)
  params.permit(:slug)
  # https://www.rubyguides.com/2019/06/rails-params/

  private

  def create_client_params
    params.require(:market_model_client).permit(
      :fio,
      :phone_number,
      {affiliate_ids: []},
      auth_user_attributes: [
        :email, :password, :password_confirmation
      ]
    )
  end

params.permit(:from, :to_free, :subject, :content)


# Вложенные параметры вынуть и разрешить так:
params
  .require(:management_letter)
  .permit(:name, :email, :message, :phonenumber, :file)


# Разрешить все параметры вложенные в поле
  def article_params
    accessed_params = params.require(:admin_article)[:form].try(:permit!)
    params.require(:admin_article).permit(
      :header,
      :hidden,
      {
        attachments: [],
        affiliate_ids: []
      }
    )
      .merge(:form => accessed_params)
  end


# Аякс контролер
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
  before_action :set_headers
  def set
    cart = basket.set set_params
    render json: cart
  end
  def set_params
    params.require(:articul)
    params.require(:count)
    params[:articul] = params[:articul].to_s
    params[:count] = params[:count].to_f
    params[:phil] = cookies[:phil]
    params.permit(:articul, :count, :phil)
  end
  def set_headers
    response.headers["Cache-Control"] = "no-cache, no-store"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end
