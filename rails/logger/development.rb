# lib/loggers/development.rb

# 
# in _config/initializers/development.rb_:
# ```
# require 'config/development'
# ```
# 
# in controller files: `::DEV_LOG.{debug|info|warn|error|fatal|unknown} message`
# 

module Loggers


class Development < Logger

  def format_message(severity, timestamp, progname, msg)
    "#{timestamp.to_formatted_s(:db)} #{severity} #{msg}\n"
  end
end


end


if Rails.env.production?
  logfile = '/dev/null'
else
  logfile = File.open("#{Rails.root}/log/development_logger.log", 'a')
  logfile.sync = true # automatically flushes data to file
  logfile.truncate 0 # Очистить при старте системы
end

DEV_LOG = ::Loggers::Development.new(logfile) # constant accessible anywhere
