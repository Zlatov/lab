# 
# rails generate
# 
rails g scaffold --help

rails routes

> app.get '/posts/1'
> response = app.response
# you now have a rails response object much like the integration tests

> response.body            # get you the HTML
> response.cookies         # hash of the cookies

Controller.new.send :act_name # Вызвать метод контроллера (экшн)

Ap.all.pluck :id
