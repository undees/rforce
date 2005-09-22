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

result = drv.describeSObjects(["SelfServiceUser", "Contact"])

puts "The SelfServiceUser object has the following fields:"
result[0].fields.each { |field| print "#{field.name}, " }

puts "\n\nThe Contact object has the following fields:"
result[1].fields.each { |field| print "#{field.name}, " }

