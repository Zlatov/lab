# _lib/logger/system.rb_
# 
# Логгер для происходящего в админке.
# 
# Добавление в rails:
# 
# _config/initializers/loggers.rb_:
# ```
# require 'logger/system'
# SYSLOG = Logger::System.init
# ```
# 
# Использование в контроллерах или задачах:
# ```
# ::SYSLOG.{debug|info|warn|error|fatal|unknown} message
# ```
# 
class Logger::System < Logger

  PATH = Rails.root.join('log/system.log')

  def self.path
    self::PATH
  end

  def self.init
    file = File.open path, 'a'
    file.sync = true
    new file
  end

  def path
    self.class::PATH
  end

  def format_message(severity, timestamp, progname, msg)
    "#{timestamp.to_formatted_s(:db)} #{severity} #{msg}\n"
  end
end
