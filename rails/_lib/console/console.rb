# Использование:
# 1. Кладём в lib/extesions/console.rb
# 2. При условии что в config/application.rb есть строка: `config.autoload_paths
# += Dir["#{config.root}/lib/extensions/**/"]`
# 3. В контроллере или вьюхе: `Console.log_header '>>> сообщение для отлова в логе или консоли'`
class Console

  def self.log_header message=''
    puts %Q(

-----------------

#{message}

-----------------

    )
    ::Rails.logger.info %Q(

-----------------

#{message}

-----------------

    )
  end
end
