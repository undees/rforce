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
#ele = SOAP::SOAPElement.new(XSD::QName.new(ns, "type"))
ele = SOAP::SOAPElement.new(XSD::QName.new(nil, "type"))
ele.text = "Contact"
ele.extraattr["xmlns"] = ns
ele.add(SOAP::SOAPElement.new("LastName", "Spaceley"))
ele.add(SOAP::SOAPElement.new("Salutation", "Mr."))

mycontact = SObject.new
mycontact.type = ele

result = drv.soap.create(Create.new([mycontact])).result
pp result


