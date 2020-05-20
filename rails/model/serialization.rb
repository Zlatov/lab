# Первый вариант определения ограничений по полям:
class Model < ApplicationRecord

  # Атрибуты разрешенные к сериализации (белый список).
  # Этот метод накладывает глобальное ограничение запрета полей при
  # вызове следующих методов:
  # .as_json(only: [:id, :name, …])
  # .to_json(only: [:id, :name, …])
  def attributes
    {
      "id" => nil,
      "email" => nil,
      "name" => nil,
      "created_at" => nil,
      # "updated_at" => nil,
    }
  end
end


# Второй вариант определения ограничений по полям:
# app/serializers/user_serializer.rb
class UserSerializer < ActiveModel::Serializer
  attributes :id, :username
end

# app/serializers/post_serializer.rb
class PostSerializer < ActiveModel::Serializer
  has_one :user
  attributes :id, :content, :created_at
end

# app/models/user.rb
class User < ActiveRecord::Base
  has_secure_password
  has_many :posts
end

# app/models/post.rb
class Post < ActiveRecord::Base
  belongs_to :user
end

# app/controllers/posts_controller.rb
class PostsController < ApplicationController
  respond_to :json

  def show
    respond_with Post.find(params[:id])
  end
end
