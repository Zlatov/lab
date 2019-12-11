require 'tiny_tds'

class MssqlClient

  @@с1 = nil

  def self.c1 params={}
    return @@c1 if params[:standing] == true && @@c1.present?

    _c1 = TinyTds::Client.new \
      username: ENV['USER'],
      password: ENV['PASSWORD'],
      host: ENV['HOST'],
      port: ENV['PORT']
    _c1.execute("USE [#{ENV['DATABASE']}];").do

    @@c1 = _c1 if params[:standing] == true
    return _c1
  end
end

connect = MssqlClient.c1

result =  connect.execute("select '1';")
result.do
result =  connect.execute("select '1';")
result.cancel
result =  connect.execute("select '1';")
result.do
result =  connect.execute("select '1';")
result.cancel
