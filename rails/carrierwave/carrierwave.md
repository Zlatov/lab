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

```rb
slide = Slide.last
slide.image = File.open('/path/to/file')
slide.save

slide.reload
slide.image
# => #<SlideUploader...>

# Превый способ
slide.remove_image!    # Удалит файл  и подготовит поле к обновлению при сохранении
# slide.remove_images! # Удалит файлы и подготовит поле к обновлению при сохранении
slide.save
# slide.save!(validate: false)

# Второй способ
slide.image.remove! # Удалит только файл
slide.update_column :image, nil # Сохранит сразу поле пустым
```


## Определяем существование фалов по базе данных, без проверки существования файлов на диске или S3

```rb
product.image.identifier.present?         # ✅ безопасно
product.images.first&.identifier.present? # ✅ безопасно
  # Как НЕ надо делать если есть S3 (проверяется наличие файла на диске, вызываея .file.exists?):
  # image.present?
  # image.blank?
  # image.file.exists?
  # image.try(:url).present?
```


## <del>Добавление</del> установка прикреплённых фалов «программно» (не через форму)

```rb
# Вариант 1, через временно сохранённые файлы в tmp
begin
  files_for_upload = []

  tmp_dir = Rails.root.join("tmp", "some_path", "some_path")
  file_path = File.join(tmp_dir, "file.name")
  files_for_upload << File.open(file_path)

  product.images = files_for_upload
  product.save!
rescue StandardError => e
  puts "== Не удалось"
  puts e.message
ensure
  # Закрываем файловые дескрипторы!
  files_for_upload&.each do |file|
    file.close if !file.closed?
  end
  if File.directory?(tmp_dir)
    FileUtils.rm_rf(tmp_dir)
    puts "== Удалена временная директория #{tmp_dir}"
  end
end

# Вариант 2. Через родной Uploader
files_for_upload = []

  file = …
  filename = …
  uploader = ProductImagesUploader.new(product, :images)
  # uploader.set_filename(filename)
  uploader.store!(file)
  files_for_upload << uploader

product.images = files_for_upload
product.save!
  # В ProductImagesUploader добавить код ниже если необходимо использовать uploader.set_filename(filename)
  # def filename
  #   # @custom_filename || super
  #   if @custom_filename
  #     # Для всех версий используем то же имя, но с префиксом версии
  #     if version_name.present?
  #       # Для версий: big_filename.jpg, view_filename.jpg и т.д.
  #       "#{version_name}_#{@custom_filename}"
  #     else
  #       # Для оригинала: filename.jpg
  #       @custom_filename
  #     end
  #   else
  #     super
  #   end
  # end
  # def set_filename(name)
  #   @custom_filename = name
  # end
```
