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
  attributes(
    :id,
    :username,
    :parent
  )

  # Отдавать атрибут name как text
  attribute :name, key: :text

  # Кастомный атрибут
  def parent
    object.parent_id.nil? ? '#' : object.parent_id
  end

  # Использование параметров для дополнительного атрибута
  attribute :test_attr do
    # Использует хелпер контроллера???:
    object.is_completed?(current_user)
    current_user.id
    # Обращение к себе через object:
    object.id
    # Параметры переданные при вызове сериализации (render json: @model, test_option: value):
    @instance_options[:test_option]
  end
end

# app/serializers/post_serializer.rb
class PostSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  include Front::ProductsHelper # опасно! в хелпере могут быть использованы
                                # хелперы рельсы, например form_tag, которых
                                # тоже будет нехватать для работы. Лучше
                                # Admin::ApplicationController.render

  attributes(
    :id,
    :content,
    :created_at,
    :icon
  )

  has_one :user

  def icon
    Admin::ApplicationController.render(
      locals: { filter: object },
      template: "admin/filters/_icon",
      layout: false
    )
  end
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
    # или
    render json: Post.find(params[:id]),               serializer: PostSerializer
    render json: Post.where(user_id: current_user.id), each_serializer: PostSerializer

    # ещё варианты для сериализации коллекции
    render json: ActiveModel::SerializableResource.new(Admin::Catalog.all.to_a).as_json
    render json: ActiveModel::SerializableResource.new(Admin::Catalog.all).as_json
    # NOTE: ActiveModel::SerializableResource.new is deprecated; use ActiveModelSerializers::SerializableResource. instead
    render json: ActiveModelSerializers::SerializableResource.new(Admin::Catalog.all).as_json
    render json: Admin::Catalog.all, each_serializer: Admin::CatalogSerializer
    render json: Admin::Catalog.all

    # Через ассоциации (has_many, belongs_to…) автоматически подгружается только
    # первый подуровень, для включения уровней ниже необходимо использовать
    # настройку:
    render json: @front_product, include: "offers_products.offer.catalogs_offers.catalog"
    render json: @front_product, include: [
      :amounts,
      :all_amounts,
      :label,
      :warehouses_sum,
      offers_products:
      {
        offer: {
          catalogs_offers: :catalog
        }
      }
    ]
  end
end
