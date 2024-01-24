# encoding: UTF-8
require 'awesome_print'
require 'net/http'
require 'uri'
require 'json'
require 'rack'

uri = URI("https://api.site.com/api.dll")
print 'uri: '.red; puts uri
print 'uri: '.red; puts uri.class
print 'URI: '.red; puts URI

# postData = Net::HTTP.post_form(URI.parse('http://lab.local/php/post/post.php'), {'postKey'=>'postValue'})
# print 'postData.body: '.red; puts postData.body

# uri = URI("http://lab.local/php/post/post.php")
# http = Net::HTTP.new(uri.host, uri.port)
# http.use_ssl = false
# request = Net::HTTP::Post.new(uri.path)
# request["HEADER1"] = 'VALUE1'
# request["HEADER2"] = 'VALUE2'

# response = http.request(request)
# print 'response: '.red; puts response

response = Net::HTTP.post(
  URI('http://lab.local/php/post/post.php'),
  # { "q" => "ruby", "max" => "50" }.to_json,
  # { "q" => "ruby", "max" => "50" }.to_query,
  # "asd=asd",
  Rack::Utils.build_query({ "q" => "ruby", "max" => "50" })
  # "Content-Type" => "application/json"
  # "Content-Type" => "application/x-www-form-urlencoded"
  # "Content-Type" => "text/plain"
)

print 'response: '.red; puts response
print 'response.body: '.red; puts response.body
# print 'response.body: '.red; p JSON.parse(response.body)['a']
# exit

response = Net::HTTP.post_form(
  URI('http://lab.local/php/post/post.php'),
  { "q" => "ruby", "max" => "50" }
)

print 'response: '.red; puts response
print 'response.body: '.red; puts response.body
# print 'response.body: '.red; p JSON.parse(response.body)['a']


puts 'GET'.green
uri = URI('https://zenonline.ru/products/bl')
query = {code: '000046651', angar_code: '000000003'}
uri.query = URI.encode_www_form(query)
response = Net::HTTP.get_response(uri)
if response.code != '200'
  print 'response.message: '.red; puts response.message
end
data = JSON.parse(response.body)
print 'data: '.red; puts data
# exit

puts 'POST'.green
# uri = URI("https://zenonline.ru/trader/000046651")
uri = URI("http://zenonline.local/trader/000046651")
response = Net::HTTP.post_form(uri, {})
if response.code != '201'
  print 'response.message: '.red; puts response.message
  return
end
data = JSON.parse(response.body)
print 'data: '.red; puts data
# exit


exit


# 
# Таймаут
# 
http = Net::HTTP.new(url.host, url.port)
http.read_timeout = 5 # seconds

http.request_post(url.path, JSON.generate(params)) do |response|
  # do something with response
  p response
end




HTTPUnknownResponse
# For unhandled HTTP extensions

HTTPInformation
# 1xx

HTTPContinue
# 100

HTTPSwitchProtocol
# 101

HTTPProcessing
# 102

HTTPEarlyHints
# 103

HTTPSuccess
# 2xx

HTTPOK
# 200

HTTPCreated
# 201

HTTPAccepted
# 202

HTTPNonAuthoritativeInformation
# 203

HTTPNoContent
# 204

HTTPResetContent
# 205

HTTPPartialContent
# 206

HTTPMultiStatus
# 207

HTTPAlreadyReported
# 208

HTTPIMUsed
# 226

HTTPRedirection
# 3xx

HTTPMultipleChoices
# 300

HTTPMovedPermanently
# 301

HTTPFound
# 302

HTTPSeeOther
# 303

HTTPNotModified
# 304

HTTPUseProxy
# 305

HTTPTemporaryRedirect
# 307

HTTPPermanentRedirect
# 308

HTTPClientError
# 4xx

HTTPBadRequest
# 400

HTTPUnauthorized
# 401

HTTPPaymentRequired
# 402

HTTPForbidden
# 403

HTTPNotFound
# 404

HTTPMethodNotAllowed
# 405

HTTPNotAcceptable
# 406

HTTPProxyAuthenticationRequired
# 407

HTTPRequestTimeOut
# 408

HTTPConflict
# 409

HTTPGone
# 410

HTTPLengthRequired
# 411

HTTPPreconditionFailed
# 412

HTTPRequestEntityTooLarge
# 413

HTTPRequestURITooLong
# 414

HTTPUnsupportedMediaType
# 415

HTTPRequestedRangeNotSatisfiable
# 416

HTTPExpectationFailed
# 417

HTTPMisdirectedRequest
# 421

HTTPUnprocessableEntity
# 422

HTTPLocked
# 423

HTTPFailedDependency
# 424

HTTPUpgradeRequired
# 426

HTTPPreconditionRequired
# 428

HTTPTooManyRequests
# 429

HTTPRequestHeaderFieldsTooLarge
# 431

HTTPUnavailableForLegalReasons
# 451

HTTPServerError
# 5xx

HTTPInternalServerError
# 500

HTTPNotImplemented
# 501

HTTPBadGateway
# 502

HTTPServiceUnavailable
# 503

HTTPGatewayTimeOut
# 504

HTTPVersionNotSupported
# 505

HTTPVariantAlsoNegotiates
# 506

HTTPInsufficientStorage
# 507

HTTPLoopDetected
# 508

HTTPNotExtended
# 510

HTTPNetworkAuthenticationRequired
# 511
