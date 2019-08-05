require 'xmpp4r'
require 'xmpp4r/client'
include Jabber
class Bot
 attr_reader :client
 def initialize jabber_id
   @jabber_id = jabber_id
   @jabber_password = "SET_PASSWORD"
 end
 def connect
   jid = JID.new(@jabber_id)
   @client = Client.new jid
   @client.connect
   @client.auth @jabber_password
   message = Message.new("maxim.z@rtr.newstar.ru", "im ruby code")
   message.type=:chat
   @client.send(message)
 end
end
Bot.new('denis.l@rtr.newstar.ru').connect 
