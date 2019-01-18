class NewsController < ApplicationController
  before_filter :find_model

  layout 'admin/special'
  prepend_view_path 'app/views/admin'

  def index
  end

  private
  def find_model
    @model = News.find(params[:id]) if params[:id]
  end
end
