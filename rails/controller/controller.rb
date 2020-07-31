class NewsController < ApplicationController
  before_filter :find_model

  before_action :asd, only: [:new, :create]
  before_action :require_login
  skip_before_action :require_login, only: [:new, :create]

  layout 'admin/special'
  layout false
  layout :resolve_layout
  prepend_view_path 'app/views/admin'

  def index
    if request.post?
    end
  end

  def update
    respond_to do |format|
      if @catalog_order.update(catalog_order_params)
        format.html do
          redirect_to action: :index, form_success: 'Catalog order was successfully updated.'
        end
        format.json { render :show, status: :ok, location: @catalog_order }
      else
        format.html { render :edit }
        format.json { render json: @catalog_order.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  def find_model
    @model = News.find(params[:id]) if params[:id]

    # Kaminari (pagination)
    User.page(7).per(50)
    User.count                     #=> 1000
    User.page(1).limit_value       #=> 20
    User.page(1).total_pages       #=> 50
    User.page(1).current_page      #=> 1
    User.page(1).next_page         #=> 2
    User.page(2).prev_page         #=> 1
    User.page(1).first_page?       #=> true
    User.page(50).last_page?       #=> true
    User.page(100).out_of_range?   #=> true
  end
  def resolve_layout
    case action_name
    when "new", "create"
      "some_layout"
    when "index"
      "other_layout"
    else
      "application"
    end
  end
end

# app/controllers/posts_controller.rb
class PostsController < ApplicationController
  respond_to :json

  def show
    respond_with Post.find(params[:id])
  end
end
