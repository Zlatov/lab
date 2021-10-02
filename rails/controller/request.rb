class NewsController < ApplicationController

  def controller_action
    request.post?
    request.url
    request.original_url
    request.base_url
    request.original_fullpath
    request.fullpath
    url_for(:only_path => true) # => 'http://somehost.org/'
    root_url # => 'http://somehost.org/'
  end
end
