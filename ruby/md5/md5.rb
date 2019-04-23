require 'awesome_print'
require 'digest'

# Compute a complete digest
a = Digest::MD5.hexdigest 'abc' #=> "90015098..."
print 'a: '.red; puts a

# Compute digest by chunks
md5 = Digest::MD5.new
md5.update "ab"
md5 << "c" # alias for #update
a = md5.hexdigest # => "90015098..."
print 'a: '.red; puts a

# Use the same object to compute another digest
md5.reset
md5 << "message"
a = md5.hexdigest
print 'a: '.red; puts a

a = Digest::MD5.hexdigest 'b3de9e4f412ed7b9cd3caecaea4add7d'
print 'a: '.red; puts a
