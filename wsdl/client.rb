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

# Describe global objects

#params = DescribeGlobal.new()
#result = drv.soap.describeGlobal(params).result
#
#my_sobjects = result.types

puts "Your login can access the following objects:"
puts drv.types.join(", ")

# Describe particular SObjects

params = DescribeSObjects.new(["SelfServiceUser", "Contact"])
result = drv.describeSObjects(["SelfServiceUser", "Contact"])

puts "\nThe SelfServiceUser object has the following fields:"
fieldnames = result[0].fields.collect {|field| field.name}
puts fieldnames.join(", ")

puts "\nThe Contact object has the following fields:"
fieldnames = result[1].fields.collect {|field| field.name}
puts fieldnames.join(", ")


# Perform a query

query_rslt = drv.query("select Id, ContactId, AccountId, Product2Id, CreatedDate, LastModifiedDate, Name, SerialNumber, DD_OS__c, SE__c, Support_Organization_ID__c, Sales_Order__c from Asset where SerialNumber = '03BM050004'")
rec = query_rslt.records[0]
#
puts "Name: #{rec.name}\tSN: #{rec.serialNumber}\tDDOS: #{rec.dD_OS__c}\tSE: #{rec.sE__c}\tORGID: #{rec.support_Organization_ID__c}"

query_rslt = drv.query("select LastName from Contact")

query_rslt.records.each {|rec| puts rec.lastName}

puts ""

query_rslt = drv.queryMore(query_rslt.queryLocator)
puts "-- -- --"
query_rslt.records.each {|rec| puts rec.lastName}

