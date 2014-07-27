require 'rforce'

email    = ENV['SALESFORCE_USER']
password = ENV['SALESFORCE_PASS']
token    = ENV['SALESFORCE_TOKEN']

binding = RForce::Binding.new \
  'https://www.salesforce.com/services/Soap/u/20.0'

binding.login \
  email, password + token

answer = binding.search \
  :searchString =>
    'find {McFakerson Co} in name fields returning account(id)'

account = answer.searchResponse.result.searchRecords.record
account_id = account.Id

puts account_id
