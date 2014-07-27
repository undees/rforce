require 'oauth'

consumer_key    = ENV['SALESFORCE_CONSUMER_KEY']
consumer_secret = ENV['SALESFORCE_CONSUMER_SECRET']

oauth_options = {
  :site               => 'https://login.salesforce.com',
  :scheme             => :body,
  :request_token_path => '/_nc_external/system/security/oauth/RequestTokenHandler',
  :authorize_path     => '/setup/secur/RemoteAccessAuthorizationPage.apexp',
  :access_token_path  => '/_nc_external/system/security/oauth/AccessTokenHandler',
}

consumer = OAuth::Consumer.new consumer_key, consumer_secret, oauth_options
# consumer.http.set_debug_output STDERR # if you're curious

request       = consumer.get_request_token
authorize_url = request.authorize_url :oauth_consumer_key => consumer_key

puts "Go to #{authorize_url} in your browser, then enter the verification code:"
verification_code = gets.strip

access = request.get_access_token :oauth_verifier => verification_code

puts "Access Token:  " + access.token
puts "Access Secret: " + access.secret
