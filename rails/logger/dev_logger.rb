# lib/config/dev_logger.rb

# 
# in _config/initializers/dev_logger.rb_:
# ```
# require 'config/dev_logger'
# ```
# 
# in controller files: `::DEV_LOGGER.{debug|info|warn|error|fatal|unknown} message`
# 
class Config::DevLogger < Logger
  def format_message(severity, timestamp, progname, msg)
    "#{timestamp.to_formatted_s(:db)} #{severity} #{msg}\n"
  end
end


if Rails.env.production?
  logfile = '/dev/null'
else
  logfile = File.open("#{Rails.root}/log/dev_logger.log", 'a')
  logfile.sync = true # automatically flushes data to file
  logfile.truncate 0 # Очистить при старте системы
end

DEV_LOGGER = ::Config::DevLogger.new(logfile) # constant accessible anywhere
