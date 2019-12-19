Sl.first.start
# => "2018-04-25 11:21:19 UTC"
Sl.first.start.localtime
# => 2018-04-25 14:21:19 +0300

# 
# Если вы хотите изменить часовой пояс Rails, но продолжайте сохранять Active
# Record в базе данных в UTC , используйте:
# _application.rb_
config.time_zone = 'Eastern Time (US & Canada)'
config.active_record.default_timezone = :utc # (по умолчанию)

# 
# Если вы хотите изменить часовой пояс Rails и иметь время хранения Active
# Record в этом часовом поясе, используйте:
# _application.rb_
config.time_zone = 'Eastern Time (US & Canada)'
config.active_record.default_timezone = :local

# Предупреждение : вам нужно подумать дважды, даже трижды, перед тем, как сохранять время в базе данных в формате, отличном от UTC.
