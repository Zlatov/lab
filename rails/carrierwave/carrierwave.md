# Carrierwave

Гем carrierwave обеспечивает простой и гибкий способ загрузки файлов в ruby
приложения.

## Установка, настройка

Добавляем гем в _Gemfile_.

```ruby
# Загрузка файлов
gem 'carrierwave', '~> 2.0'
```

Обновим гемы и создадим загрузчик изображений.

```bash
bundle

rails g uploader Image
# Лучше добавить имя модели к которой загружаем
rails g uploader ProductImage
```

Добавим поле к модели

```bash
# Сгенерирует готовый к миграции код, однако можно задать default: {}...
rails g migration add_image_to_offer image:jsonb
rails db:migrate
```

Изменим поведение поля модели _app/models/\<model\>.rb_

```ruby

t.jsonb "images"
# Одно изображение на поле
mount_uploader :image, ImageUploader
# Много изображений на поле
mount_uploaders :images, ProductImageUploader
```

Контроллер

```rb
  # Простой способ удалить файл по галке
  def product_params
    params.require(:product).permit(
      …
      :image,
      :remove_image
    )
  end

  # Удаление файлов через галку требует убрать удаляемые файлы из параметров, в
  # то время как существует способ удалять файлы просто уничтожая html код
  # формы отвечающий за передачу информации о файле.
  def admin_affiliate_params
    # Удаляем отмеченные файлы
    if params[:admin_affiliate]&.[](:remove_files).present? && params[:admin_affiliate]&.[](:files).present?
      params[:admin_affiliate][:files] = params[:admin_affiliate][:files] - params[:admin_affiliate][:remove_files]
    end
    params.require(:admin_affiliate).permit(
      :name,
      …
      files: []
    )
```

Вьюха

```html
<!-- app/views/products/_form.html.erb -->
<%= form_with(model: product) do |form| %>

  <div class="row mb-3">
    <div class="col">
      <b><%= form.label :image, class: 'form-label' %></b>
      <% if form.object.image.present? %>
        <div>
          <% image = form.object.image %>
          <%= image_tag image.url %>
        </div>
        <p>
          <%= link_to image.identifier, image.url, target: '_blank' %>
        </p>
        <p>
          <%= form.hidden_field :image, value: image.identifier %>
          <%= form.check_box :remove_image, {class: 'form-check-input'}, image.identifier, nil %>
          <%= form.label :remove_image, 'Удалить', class: 'form-check-label user-select-none mb-0' %>
        </p>
      <% end %>
      <%= form.file_field :image, class: 'form-control form-control-sm' %>
      <%= field_errors form.object, :image %>
    </div>
  </div>

  <div class="actions">
    <%= form.submit %>
  </div>
<% end %>
```


## Удаление файлов

Странно, что в 2021 году до сих пор симатическая проблема в удалении файлов, вот два способа удаления:

```rb
slide = Slide.last
slide.image = File.open('/path/to/file')
slide.save

slide.reload
slide.image
# => #<SlideUploader...>

# Превый способ
slide.remove_image! # Удалит файл и подготовит поле к обновлению при сохранении
slide.save

# Второй способ
slide.image.remove! # Удалит только файл
slide.update_column :image, nil # Сохранит сразу поле пустым

# Почему в первом способе к модели добавляются синтетические методы - имхо
# некрасиво.
# 
# Во втором способе я не нашел метод как можно обнулить поле, а сохранить
# отдельно через save.
```

```rb
# Проверка есть ли запись о файлах в БД без проверки существования файла на диске.
product.image.identifier.present?         # ✅ безопасно
product.images.first&.identifier.present? # ✅ безопасно
  # Как НЕ надо делать если есть S3 (проверяется наличие файла на диске, вызываея .file.exists?):
  # image.present?
  # image.blank?
  # image.file.exists?
  # image.try(:url).present?
```
