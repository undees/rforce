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


# NOTE: The following does NOT work -- problem with soap4r-1_5_5?

ns = "urn:sobject.partner.soap.sforce.com"
#include XSD
#result = drv.soap.create(:sObjects =>
#  [
#    {
#      QName.new(ns, "type") => "Contact",
#      QName.new(ns, "Id") => "id",
#      :FirstName => "Joe",
#      :lastname => "Blow",
#      :Salutation => "Mr.",
#      :Phone => "999.999.9999",
#      :Title => "Purchasing Director",
#    }
#  ]
#).result

sobj = OrderedHash.new
sobj[XSD::QName.new(ns, 'type')] = "Contact"
sobj[:LastName] = "Blow"
result = drv.soap.create(:sObjects => [sobj])

pp result


