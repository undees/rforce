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

#result = drv.describeSObjects(["Contact"])
#pp result


# NOTE: The following does NOT work -- problem with soap4r-1_5_5?

mycontact = SObject.new
mycontact.type = "Contact"
mycontact.any = {"LastName" => "Spaceley"}

params = Create.new([mycontact])
result = drv.soap.create(params).result
pp result


