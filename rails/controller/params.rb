exit

params.permit(:from, :to_free, :subject, :content)

# Вложенные параметры вынуть и разрешить так:
params
  .require(:management_letter)
  .permit(:name, :email, :message, :phonenumber, :file)


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
