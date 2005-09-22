#!/usr/bin/ruby
# vim: set tw=72 ai sw=2:

### User Configurable Constants ###

DefaultUser = 'changeme@salesforce.com'
DefaultPasswd = 'changemetoo'

###################################

require 'wsdl'
require 'pp'

user = ENV['RFORCE_USER'] || DefaultUser
passwd = ENV['RFORCE_PASS'] || DefaultPasswd


# Open a connection and login

if $DEBUG
  drv = RForce::WSDL.new(user, passwd, $DEBUG, 
	"http://na1-api.salesforce.com/services/Soap/c/6.0")
else
  drv = RForce::WSDL.new(user, passwd)
end

query_results = drv.query("select Id from Asset where SerialNumber like '%04BM%'")
ids = query_results.records.map { |rslt| rslt.id }

drv.retrieve("Name, SerialNumber, SE__c", "Asset", ids).each do |obj|
  puts "Name: #{obj.name}\tSN: #{obj.serialNumber}\tSE: #{obj.sE__c}"
end
