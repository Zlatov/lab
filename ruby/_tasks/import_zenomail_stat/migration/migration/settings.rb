# byebug

ActiveRecord::Base.establish_connection(
  adapter: "postgresql",
  encoding: "unicode",
  database: ENV["IMPORT_ZENOMAIL_STAT_DATABASE"],
  pool: 5,
  timeout: 5000,
  user: ENV["IMPORT_ZENOMAIL_STAT_USER"],
  password: ENV["IMPORT_ZENOMAIL_STAT_PASSWORD"]
)
