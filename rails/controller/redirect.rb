redirect_to action: "show", id: 5
redirect_to @post
redirect_to "http://www.rubyonrails.org"
redirect_to "/images/screenshot.jpg"
redirect_to posts_url
redirect_to proc { edit_post_url(@post) }
redirect_to post_url(@post), status: :found
redirect_to action: 'atom', status: :moved_permanently
redirect_to post_url(@post), status: 301
redirect_to action: 'atom', status: 302
