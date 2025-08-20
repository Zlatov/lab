class PageImagesUploader < CarrierWave::Uploader::Base
  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  # include CarrierWave::MiniMagick
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url(*args)
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process scale: [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end
  def scale(width, height)
    # resize_to_limit - Изменяет размер изображения только в том случае, если оно больше указанных размеров. Результирующее изображение может быть короче или уже, чем указано в меньшем измерении, но не будет больше указанных значений.
    # resize_to_fit - Изображение может быть короче или уже, чем указано в меньшем измерении, но не будет больше указанных значений.
    # resize_to_fill - При необходимости обрежьте изображение в большем размере. При желании можно указать «гравитацию», например «Центр» или «Северо-Восток».
    # resize_and_pad - При необходимости оставшаяся область будет заполнена заданным цветом, который по умолчанию является прозрачным (для gif и png, белый для jpeg). При желании можно указать «гравитацию», как указано выше.
    # do something
  end

  # Ресайз если размеры не подходящие, размеры определяются динамически, к примеру хранятся в БД.
  process :scale
  def scale
    image = MiniMagick::Image.open(current_path)
    width = ApplicationSetting.instance.banner_origin_x
    height = ApplicationSetting.instance.banner_origin_y
    resize_to_fill width, height if image.width != width || image.height != height
  end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process resize_to_fit: [50, 50]
  # end
  DIMENSIONS = {
    thumbnail: [200, 200],
  }
  version :thumbnail, if: :image? do
    process resize_to_fit: self.superclass::DIMENSIONS[:thumbnail]
  end
  def dimensions
    self.class::DIMENSIONS
  end

  # Add an allowlist of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  # def extension_allowlist
  #   %w(jpg jpeg gif png)
  # end
  def extension_allowlist
    %w(jpg jpeg gif png)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

  private

  def image?(attachment)
    %w(jpg jpeg gif png).include?(attachment.extension)
  end
end
