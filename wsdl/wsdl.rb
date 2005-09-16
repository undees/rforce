# vim: set tw=72 ai sw=2:

require 'defaultDriver.rb'
require 'sforceDriver.rb'

module RForce
 	
  # Main class for RForce objects
  class WSDL

    attr_reader :soap, :fields

    # Creator - handle the resetting of the endpoint URL and sessionId
    def initialize(user, password, wiredump=false, endpoint=nil)

      sessionid_handler = SessionHeaderHandler.new
      calloptions_handler = CallOptionsHandler.new

      @soap = Soap.new(endpoint)

      @soap.headerhandler << sessionid_handler
      @soap.headerhandler << calloptions_handler

      @soap.wiredump_dev = STDERR if wiredump

      params = Login.new(user, password)
      login_result = @soap.login(params).result

      sessionid_handler.sessionid = login_result.sessionId
      calloptions_handler.client = 'client'

      @soap.endpoint_url = login_result.serverUrl unless endpoint

    end
  end
end
