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

params = DescribeGlobal.new()
result = drv.soap.describeGlobal(params).result

my_sobjects = result.types

puts "Your login can access the following objects:"
my_sobjects.each { |type| puts type }
puts ""

# Describe particular SObjects

params = DescribeSObjects.new(["Account", "Asset", "Product"])
result = drv.soap.describeSObjects(params).result

acct_fields = result[0].fields

puts "The Account object has the following fields:"
acct_fields.each { |field| puts field.name }
puts


# Perform a query

params = Query.new("select Name, Phone, Fax from Account")
accounts = drv.soap.query(params).result.records

puts "Account, Phone, Fax"
accounts.each { |rec| puts "#{rec.name}, #{rec.phone}, #{rec.fax}" }


