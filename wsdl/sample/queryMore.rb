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

query_rslt = drv.query("select LastName from Contact")
puts "Size: #{query_rslt.size}\t Done: #{query_rslt.done}\tLoc: #{query_rslt.queryLocator}"

query_rslt = drv.queryMore(query_rslt.queryLocator)
puts "Size: #{query_rslt.size}\t Done: #{query_rslt.done}\tLoc: #{query_rslt.queryLocator}"

