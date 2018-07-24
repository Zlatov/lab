# image = Watermarkize::Image.open image_path
# image.mark watermark2_path, dx: 30, dy: 20
# image.write output2_path

module Watermarkize
  class Image
    class Exception < Exception
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

    @image = nil

    def initialize
      print 'self.class.to_s: '.red; puts self.class.to_s
      self
    end

    def self.open path
      raise Exception.new Exception::Error::NOFILE if !File.exist? path
      # begin
        @image = MiniMagick::Image.open(path)
      # rescue => e
      #   raise Exception.new Exception::Error::UNDEFINED
      # end
      new
    end

    def mark watermark_path
      print 'watermark_path: '.red; puts watermark_path
      self
    end
  end
end
