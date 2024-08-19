# PKCE коды
# 
# Proof of Key Code Exchange - Доказательство обмена ключевым кодом
# 
# Генерируем code_verifier и code_challenge.
# 
# Обычно code_verifier сохраняем у себя, code_challenge - высылаем с первым
# запросом, который должен вернуть основной ключ доступа, а так же указываем
# каким методом шифровался code_challenge.
# 
# code_verifier высылается при следующих запросах, code_verifier подтверждает
# что именно мы отправляли первый запрос для получения основного ключа
# доступа.

require 'securerandom'
require 'base64'
require 'digest'
require 'awesome_print'

code_verifier = SecureRandom.hex(64)
code_challenge = Base64.urlsafe_encode64(Digest::SHA256.new.digest(code_verifier)).gsub(/=/, '')
code_challenge_method = 's256' # На примере VK API

print 'code_verifier: '.red; puts code_verifier
print 'code_challenge: '.red; puts code_challenge
