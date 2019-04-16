class NewsController < ApplicationController
  before_filter :find_model

  layout 'admin/special'
  prepend_view_path 'app/views/admin'
  layout :resolve_layout

  def index
  end

  private
  def find_model
    @model = News.find(params[:id]) if params[:id]
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
