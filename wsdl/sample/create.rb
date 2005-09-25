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
	"http://na1-api.salesforce.com/services/Soap/u/6.0")
else
  drv = RForce::WSDL.new(user, passwd)
end

#result = drv.describeSObjects(["Contact"])
#pp result


sobj = RForce::makeSObject("Contact", 
	:LastName => "Blow",
	:FirstName => "Joe",
	:Salutation => "Mr.",
	:Phone => "555-555-1212")

pp drv.create([sobj])
