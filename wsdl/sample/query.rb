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

query_rslt = drv.query("select Id, Name, SerialNumber from Asset where SerialNumber like '%04BM%'")

query_rslt.records.each do |rec|
  puts "Id: #{rec.id}\tName: #{rec.name}\tSN: #{rec.serialNumber}"
end
