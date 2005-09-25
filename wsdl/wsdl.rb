# vim: set tw=72 ai sw=2:

require 'defaultDriver.rb'
require 'sforceDriver.rb'

# RForce module for using the Salesforce.com "SForce" API
module RForce
 	
  # This is the WSDL interface rather than "raw" XML interface
  class WSDL

    # The underlying SOAP binding
    attr_reader :soap

    # Specifies how an organization's data is encoded, such as UTF-8 or
    # ISO8859/1
    attr_reader :encoding

    # Maximum number of records allowed in a create, update, or delete
    # call
    attr_reader :maxBatchSize

    # Array of available objects for your organization.
    attr_reader :types

    # Create a new rforce object, handling the resetting of the endpoint
    # URL and sessionId
    def initialize(user, password, wiredump=false, endpoint=nil)

      @fields = {}
      @soap = Soap.new(endpoint)

      sessionid_handler = SessionHeaderHandler.new
      calloptions_handler = CallOptionsHandler.new


      @soap.headerhandler << sessionid_handler
      @soap.headerhandler << calloptions_handler

      @soap.wiredump_dev = STDERR if wiredump

      params = Login.new(user, password)
      login_result = @soap.login(params).result

      sessionid_handler.sessionid = login_result.sessionId
      calloptions_handler.client = 'client'

      @soap.endpoint_url = login_result.serverUrl unless endpoint

      #result = soap.describeGlobal(DescribeGlobal.new).result
      result = describeGlobal

      @encoding = result.encoding
      @maxBatchSize = result.maxBatchSize
      @types = result.types

    end

    # Return the server timestamp
    def getServerTimestamp
      soap.getServerTimestamp(GetServerTimestamp.new).result.timestamp
    end

    # Retrieve a list of available SObjects for this login
    def describeGlobal
      soap.describeGlobal(DescribeGlobal.new).result
    end

    # Describe a list of SObjects (what fields, etc.)
    # [Note: should really cache the results]
    def describeSObjects(list)
      soap.describeSObjects(DescribeSObjects.new(list)).result
    end

    # Perform a SOQL query
    def query(querystr)
      soap.query(Query.new(querystr)).result
    end

    # Continue a SOQL query
    def queryMore(locator)
      soap.queryMore(QueryMore.new(locator)).result
    end

    # Retrieve a list of specific objects
    def retrieve(fieldList, from, ids)
      soap.retrieve(Retrieve.new(fieldList, from, ids)).result
    end

    # Create an SObject
    def RForce.makeSObject(type, params)
      sobj = OrderedHash.new
      sobj[XSD::QName.new('urn:sobject.partner.soap.sforce.com', 'type')] = type
      params.keys.collect { |key| sobj[key] = params[key] }
      sobj
    end

    def create(sobjects)
      soap.create(:sObjects => sobjects).result
    end

  end

  class SObject
    attr_accessor :type, :id, :fieldsToNull, :any

    def initialize(type, id, fieldsToNull, any)
      @type = type
      @id = id
      @fieldsToNull = fieldsToNull
      @any = any

      sobj = OrderedHash.new
      sobj[XSD::QName.new('urn:sobject.partner.soap.sforce.com', 'type')] = type
      any.keys.collect { |key| sobj[key] = any[key] }
      sobj
    end

  end

end
