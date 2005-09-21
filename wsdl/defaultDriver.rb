require 'default.rb'

require 'soap/rpc/driver'

class Soap < ::SOAP::RPC::Driver
  DefaultEndpointUrl = "https://www.salesforce.com/services/Soap/u/6.0"
  MappingRegistry = ::SOAP::Mapping::Registry.new

  Methods = [
    [ "",
      "login",
      [ ["in", "parameters", ["::SOAP::SOAPElement", "urn:partner.soap.sforce.com", "login"], true],
        ["out", "parameters", ["::SOAP::SOAPElement", "urn:partner.soap.sforce.com", "loginResponse"], true] ],
      { :request_style =>  :document, :request_use =>  :literal,
        :response_style => :document, :response_use => :literal }
    ],
    [ "",
      "describeSObject",
      [ ["in", "parameters", ["::SOAP::SOAPElement", "urn:partner.soap.sforce.com", "describeSObject"], true],
        ["out", "parameters", ["::SOAP::SOAPElement", "urn:partner.soap.sforce.com", "describeSObjectResponse"], true] ],
      { :request_style =>  :document, :request_use =>  :literal,
        :response_style => :document, :response_use => :literal }
    ],
    [ "",
      "describeSObjects",
      [ ["in", "parameters", ["::SOAP::SOAPElement", "urn:partner.soap.sforce.com", "describeSObjects"], true],
        ["out", "parameters", ["::SOAP::SOAPElement", "urn:partner.soap.sforce.com", "describeSObjectsResponse"], true] ],
      { :request_style =>  :document, :request_use =>  :literal,
        :response_style => :document, :response_use => :literal }
    ],
    [ "",
      "describeGlobal",
      [ ["in", "parameters", ["::SOAP::SOAPElement", "urn:partner.soap.sforce.com", "describeGlobal"], true],
        ["out", "parameters", ["::SOAP::SOAPElement", "urn:partner.soap.sforce.com", "describeGlobalResponse"], true] ],
      { :request_style =>  :document, :request_use =>  :literal,
        :response_style => :document, :response_use => :literal }
    ],
    [ "",
      "describeLayout",
      [ ["in", "parameters", ["::SOAP::SOAPElement", "urn:partner.soap.sforce.com", "describeLayout"], true],
        ["out", "parameters", ["::SOAP::SOAPElement", "urn:partner.soap.sforce.com", "describeLayoutResponse"], true] ],
      { :request_style =>  :document, :request_use =>  :literal,
        :response_style => :document, :response_use => :literal }
    ],
    [ "",
      "describeTabs",
      [ ["in", "parameters", ["::SOAP::SOAPElement", "urn:partner.soap.sforce.com", "describeTabs"], true],
        ["out", "parameters", ["::SOAP::SOAPElement", "urn:partner.soap.sforce.com", "describeTabsResponse"], true] ],
      { :request_style =>  :document, :request_use =>  :literal,
        :response_style => :document, :response_use => :literal }
    ],
    [ "",
      "create",
      [ ["in", "parameters", ["::SOAP::SOAPElement", "urn:partner.soap.sforce.com", "create"], true],
        ["out", "parameters", ["::SOAP::SOAPElement", "urn:partner.soap.sforce.com", "createResponse"], true] ],
      { :request_style =>  :document, :request_use =>  :literal,
        :response_style => :document, :response_use => :literal }
    ],
    [ "",
      "update",
      [ ["in", "parameters", ["::SOAP::SOAPElement", "urn:partner.soap.sforce.com", "update"], true],
        ["out", "parameters", ["::SOAP::SOAPElement", "urn:partner.soap.sforce.com", "updateResponse"], true] ],
      { :request_style =>  :document, :request_use =>  :literal,
        :response_style => :document, :response_use => :literal }
    ],
    [ "",
      "delete",
      [ ["in", "parameters", ["::SOAP::SOAPElement", "urn:partner.soap.sforce.com", "delete"], true],
        ["out", "parameters", ["::SOAP::SOAPElement", "urn:partner.soap.sforce.com", "deleteResponse"], true] ],
      { :request_style =>  :document, :request_use =>  :literal,
        :response_style => :document, :response_use => :literal }
    ],
    [ "",
      "retrieve",
      [ ["in", "parameters", ["::SOAP::SOAPElement", "urn:partner.soap.sforce.com", "retrieve"], true],
        ["out", "parameters", ["::SOAP::SOAPElement", "urn:partner.soap.sforce.com", "retrieveResponse"], true] ],
      { :request_style =>  :document, :request_use =>  :literal,
        :response_style => :document, :response_use => :literal }
    ],
    [ "",
      "convertLead",
      [ ["in", "parameters", ["::SOAP::SOAPElement", "urn:partner.soap.sforce.com", "convertLead"], true],
        ["out", "parameters", ["::SOAP::SOAPElement", "urn:partner.soap.sforce.com", "convertLeadResponse"], true] ],
      { :request_style =>  :document, :request_use =>  :literal,
        :response_style => :document, :response_use => :literal }
    ],
    [ "",
      "getDeleted",
      [ ["in", "parameters", ["::SOAP::SOAPElement", "urn:partner.soap.sforce.com", "getDeleted"], true],
        ["out", "parameters", ["::SOAP::SOAPElement", "urn:partner.soap.sforce.com", "getDeletedResponse"], true] ],
      { :request_style =>  :document, :request_use =>  :literal,
        :response_style => :document, :response_use => :literal }
    ],
    [ "",
      "getUpdated",
      [ ["in", "parameters", ["::SOAP::SOAPElement", "urn:partner.soap.sforce.com", "getUpdated"], true],
        ["out", "parameters", ["::SOAP::SOAPElement", "urn:partner.soap.sforce.com", "getUpdatedResponse"], true] ],
      { :request_style =>  :document, :request_use =>  :literal,
        :response_style => :document, :response_use => :literal }
    ],
    [ "",
      "query",
      [ ["in", "parameters", ["::SOAP::SOAPElement", "urn:partner.soap.sforce.com", "query"], true],
        ["out", "parameters", ["::SOAP::SOAPElement", "urn:partner.soap.sforce.com", "queryResponse"], true] ],
      { :request_style =>  :document, :request_use =>  :literal,
        :response_style => :document, :response_use => :literal }
    ],
    [ "",
      "queryMore",
      [ ["in", "parameters", ["::SOAP::SOAPElement", "urn:partner.soap.sforce.com", "queryMore"], true],
        ["out", "parameters", ["::SOAP::SOAPElement", "urn:partner.soap.sforce.com", "queryMoreResponse"], true] ],
      { :request_style =>  :document, :request_use =>  :literal,
        :response_style => :document, :response_use => :literal }
    ],
    [ "",
      "search",
      [ ["in", "parameters", ["::SOAP::SOAPElement", "urn:partner.soap.sforce.com", "search"], true],
        ["out", "parameters", ["::SOAP::SOAPElement", "urn:partner.soap.sforce.com", "searchResponse"], true] ],
      { :request_style =>  :document, :request_use =>  :literal,
        :response_style => :document, :response_use => :literal }
    ],
    [ "",
      "getServerTimestamp",
      [ ["in", "parameters", ["::SOAP::SOAPElement", "urn:partner.soap.sforce.com", "getServerTimestamp"], true],
        ["out", "parameters", ["::SOAP::SOAPElement", "urn:partner.soap.sforce.com", "getServerTimestampResponse"], true] ],
      { :request_style =>  :document, :request_use =>  :literal,
        :response_style => :document, :response_use => :literal }
    ],
    [ "",
      "setPassword",
      [ ["in", "parameters", ["::SOAP::SOAPElement", "urn:partner.soap.sforce.com", "setPassword"], true],
        ["out", "parameters", ["::SOAP::SOAPElement", "urn:partner.soap.sforce.com", "setPasswordResponse"], true] ],
      { :request_style =>  :document, :request_use =>  :literal,
        :response_style => :document, :response_use => :literal }
    ],
    [ "",
      "resetPassword",
      [ ["in", "parameters", ["::SOAP::SOAPElement", "urn:partner.soap.sforce.com", "resetPassword"], true],
        ["out", "parameters", ["::SOAP::SOAPElement", "urn:partner.soap.sforce.com", "resetPasswordResponse"], true] ],
      { :request_style =>  :document, :request_use =>  :literal,
        :response_style => :document, :response_use => :literal }
    ],
    [ "",
      "getUserInfo",
      [ ["in", "parameters", ["::SOAP::SOAPElement", "urn:partner.soap.sforce.com", "getUserInfo"], true],
        ["out", "parameters", ["::SOAP::SOAPElement", "urn:partner.soap.sforce.com", "getUserInfoResponse"], true] ],
      { :request_style =>  :document, :request_use =>  :literal,
        :response_style => :document, :response_use => :literal }
    ]
  ]

  def initialize(endpoint_url = nil)
    endpoint_url ||= DefaultEndpointUrl
    super(endpoint_url, nil)
    self.mapping_registry = MappingRegistry
    init_methods
  end

private

  def init_methods
    Methods.each do |definitions|
      opt = definitions.last
      if opt[:request_style] == :document
        add_document_operation(*definitions)
      else
        add_rpc_operation(*definitions)
        qname = definitions[0]
        name = definitions[2]
        if qname.name != name and qname.name.capitalize == name.capitalize
          ::SOAP::Mapping.define_singleton_method(self, qname.name) do |*arg|
            __send__(name, *arg)
          end
        end
      end
    end
  end
end

