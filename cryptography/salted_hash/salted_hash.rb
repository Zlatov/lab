require 'awesome_print'
require 'securerandom'
require 'digest'

class SaltedHash
  class Error < StandardError; end
  class ValidationError < Error; end

  SALT = ENV.fetch('SALTED_HASH_SALT', 'asd')
  PEPPER = ENV.fetch('SALTED_HASH_PEPPER', 'zxc')

  def self.encode(data, salt = SALT)
    validate_string data
    validate_string salt
    validate_string PEPPER
    hash = Digest::SHA256.hexdigest(data)
    salt = Digest::SHA256.hexdigest(salt)
    Digest::SHA256.hexdigest(salt + hash + PEPPER)
  end

  def self.verify(data, hash, salt = SALT)
    validate_string data
    validate_string hash
    validate_string salt
    encode(data, salt) == hash
  end

  private

  def self.validate_string(string)
    if !string.is_a?(String) || string.empty? || string.size > 100
      raise ValidationError, 'Некорректные входные данные: ожидается непустая строка (макс. 100 символов)'
    end
  end
end

# Если статическая соль:
data = 'asd@asd.asd'
hash = SaltedHash.encode(data)
print 'hash: '.red; puts hash

verify = SaltedHash.verify(data, hash)
print 'verify: '.red; puts verify

# Если решу соль хранить в БД:
data = 'asd@asd.asd'
salt = SecureRandom.hex(20)
hash = SaltedHash.encode(data, salt)
print 'hash: '.red; puts hash

verify = SaltedHash.verify(data, hash, salt)
print 'verify: '.red; puts verify
