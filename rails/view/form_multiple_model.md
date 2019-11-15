_client.rb_
```rb
class Client

  has_one :auth_user,
    class_name: "User",
    foreign_key: :client_id,
    primary_key: :id
  accepts_nested_attributes_for :auth_user
```

_controller.rb_
```rb
  def new
    @client = ::Client.new
    @client.build_auth_user
    @select_affiliates = ::Affiliate.select_list
  end

  # POST /resource
  def create
    @client = ::Client.new create_client_params
    if @client.save
    ...
  end

  def create_client_params
    params.require(:client).permit(
      :fio, :phone_number, :affiliate_id,
      auth_user_attributes: [
        :email, :password, :password_confirmation
      ]
    )
  end
```

_new.html.erb_
```
<%= form_for @client, url: user_registration_path do |client| %>

  <%= client.fields_for :auth_user do |user| %>

    <%= user.label :email %>
    <%= user.email_field :email, autofocus: true %>
    <%= field_errors @client.auth_user, :email %>

  <% end %>

  <%= client.label :fio %>
  <%= client.text_field :fio %>
  <%= field_errors @client, :fio %>

<% end %>
```
