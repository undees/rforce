require 'rforce'

oauth = {
  :consumer_key    => ENV['SALESFORCE_CONSUMER_KEY'],
  :consumer_secret => ENV['SALESFORCE_CONSUMER_SECRET'],
  :access_token    => ENV['SALESFORCE_ACCESS_TOKEN'],
  :access_secret   => ENV['SALESFORCE_ACCESS_SECRET'],
  :login_url       => 'https://login.salesforce.com/services/OAuth/u/20.0'
}

binding = RForce::Binding.new \
  'https://www.salesforce.com/services/Soap/u/20.0',
  nil,
  oauth

binding.login_with_oauth

answer = binding.search \
  :searchString =>
    'find {McFakerson Co} in name fields returning account(id)'

account = answer.searchResponse.result.searchRecords.record
account_id = account.Id

puts account_id
