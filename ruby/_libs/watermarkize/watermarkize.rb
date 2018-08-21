# 
# Watermarkize
# =============
# 
# Наложение водяного знака по центру изображения или повторяя как паттерн.
# 
# Использоваие
# ------------
# 
# 1. Открыть изображение
#   ```
#     image = Watermarkize::Image.open image_path
#   ```
# 2. Наложить водяной знак
#   * повторяющийся:
#     ```
#       image.mark watermark_path, dx: 40, dy: 40
#     ```
#   * по центру:
#     ```
#       image.mark watermark120_path, repeat: false
#     ```
# 3. Сохранить
#   * На то же место
#     ```
#       image.save
#     ```
#   * C указанием нового места без указания расширения (восстановит
#     расширение из пути к оригинальному изображению)
#     ```
#       image.save '/path/to/image/without/extension'
#     ```
#   * C указанием нового места c указания расширения
#     ```
#       image.save '/path/to/image/with.extension', repair_image_extension: false
#     ```
#     При необходимости можно принудительно запретить восстанавливать расширение
#     указав опцию `repair_image_extension: false`.
# 

module Watermarkize

  class Image

    class Exception < ::Exception
      class Error
        UNDEFINED = 0
        NOFILE = 1
        def self.get_message code
          case code
          when 1
            'Файл изображения не найден'
          when 0
            'Неизвестная ошибка'
          else
            'Неизвестная ошибка'
          end
        end
      end
      def self.new code
        super Error.get_message(code)
      end
    end

    @@default_options = {
      dx: 0,
      dy: 0,
      repair_image_extension: true,
      repeat: true
    }

    def initialize path, options = nil
      raise Exception.new Exception::Error::NOFILE if !File.exist? path
      @repair_image_ext = true
      set_options(options)
      @image = MiniMagick::Image.open(path)
      @output = @image
      @image_path = path
      self
    end

    def self.open path, options=nil
      new path, options
    end

    def mark watermark_path, options=nil
      raise Exception.new Exception::Error::NOFILE if !File.exist? watermark_path
      @watermark = MiniMagick::Image.open(watermark_path)
      set_options(options)
      if @options[:repeat]
        mark_repeat
      else
        mark_center
      end
      self
    end

    def save output_path = nil, options = nil
      set_options(options)
      @output.write prepare_output_path(output_path)
    end

    private

    def set_options options
      @options ||= @@default_options.clone
      @options = @options.merge(options) if !options.nil?
    end

    def prepare_output_path output_path
      if !output_path.nil? && @options[:repair_image_extension]
        ext = File.extname(output_path)
        if ext.empty?
          output_path = "#{output_path}#{File.extname(@image_path)}"
        end
      end
      output_path ||= @image_path
      output_path
    end

    def mark_center
      # max_side = @image.width > @image.height ? @image.width : @image.height
      min_side = @image.width < @image.height ? @image.width : @image.height
      @watermark.resize "#{min_side}x#{min_side}"
      @output = @image.composite(@watermark) do |o|
        o.gravity 'center'
      end
    end

    def mark_repeat
      @ww = @watermark.width
      @wh = @watermark.height
      repeat_by_x = @image.width.divmod(@options[:dx] + @ww)[0] + 1
      repeat_by_y = @image.height.divmod(@options[:dy] + @wh)[0] + 1
      c = @image
      repeat_by_x.times do |x|
        repeat_by_y.times do |y|
          l=(@options[:dx] + @ww) * x + (@options[:dx].to_f / 2).floor
          t=(@options[:dy] + @wh) * y + (@options[:dy].to_f / 2).floor
          c = c.composite(@watermark) do |o|
            o.geometry "+#{l}+#{t}"
          end
        end
      end
      @output = c
    end
  end
end
