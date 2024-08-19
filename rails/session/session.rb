# write data
session[:name] = 'Akshay'

# read data
name = session[:name]
name = session.fetch(:name)
name = session.fetch(:name, 'default')
name = session.fetch(:name, nil)

# nested data
session["one"] = { "two" => "3" }
session.dig("one", "two") # 3
session.dig(:one, "two") # 3
session.dig("one", :two) # nil

# update
session["action"] = "NEW"
session.update(action: "CREATE")

# delete
session.delete("action")
