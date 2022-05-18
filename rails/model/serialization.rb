# https://thoughtbot.com/blog/better-serialization-less-as-json
# https://til.codes/active-model-serializer-vz-jbuilder-vz-rabl-vz-grape-entity-vz-roar/
# https://learn.co/lessons/using-active-model-serializer

# Если модель PORO, то необходимо либо:
# include ActiveModel::Serialization
# - предоставит базовую сериализацию методом serializable_hash
# include ActiveModel::Serializers::JSON
# - предоставит метод as_json...

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
# или сгенерировать
# rails g serializer admin/catalog
class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :parent
  # Отдавать атрибут name как text
  attribute :name, key: :text
  # Кастомный атрибут
  def parent
    object.parent_id.nil? ? '#' : object.parent_id
  end
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
    hash = PostSerializer.new(Post.first).as_json
    # или
    respond_with Post.find(params[:id])

    # ещё варианты для сериализации коллекции
    render json: ActiveModel::SerializableResource.new(Admin::Catalog.all.to_a).as_json
    render json: ActiveModel::SerializableResource.new(Admin::Catalog.all).as_json
    render json: Admin::Catalog.all, each_serializer: Admin::CatalogSerializer
    render json: Admin::Catalog.all
  end
end
