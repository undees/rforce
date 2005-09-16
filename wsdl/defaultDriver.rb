require 'default.rb'

require 'soap/rpc/driver'

class Soap < ::SOAP::RPC::Driver
  DefaultEndpointUrl = "https://www.salesforce.com/services/Soap/u/6.0"
  MappingRegistry = ::SOAP::Mapping::Registry.new

  Methods = [
    ["login", "login",
      [
        ["in", "parameters", ["::SOAP::SOAPElement", "urn:partner.soap.sforce.com", "login"]],
        ["out", "parameters", ["::SOAP::SOAPElement", "urn:partner.soap.sforce.com", "loginResponse"]]
      ],
      "", nil, :document
    ],
    ["describeSObject", "describeSObject",
      [
        ["in", "parameters", ["::SOAP::SOAPElement", "urn:partner.soap.sforce.com", "describeSObject"]],
        ["out", "parameters", ["::SOAP::SOAPElement", "urn:partner.soap.sforce.com", "describeSObjectResponse"]]
      ],
      "", nil, :document
    ],
    ["describeSObjects", "describeSObjects",
      [
        ["in", "parameters", ["::SOAP::SOAPElement", "urn:partner.soap.sforce.com", "describeSObjects"]],
        ["out", "parameters", ["::SOAP::SOAPElement", "urn:partner.soap.sforce.com", "describeSObjectsResponse"]]
      ],
      "", nil, :document
    ],
    ["describeGlobal", "describeGlobal",
      [
        ["in", "parameters", ["::SOAP::SOAPElement", "urn:partner.soap.sforce.com", "describeGlobal"]],
        ["out", "parameters", ["::SOAP::SOAPElement", "urn:partner.soap.sforce.com", "describeGlobalResponse"]]
      ],
      "", nil, :document
    ],
    ["describeLayout", "describeLayout",
      [
        ["in", "parameters", ["::SOAP::SOAPElement", "urn:partner.soap.sforce.com", "describeLayout"]],
        ["out", "parameters", ["::SOAP::SOAPElement", "urn:partner.soap.sforce.com", "describeLayoutResponse"]]
      ],
      "", nil, :document
    ],
    ["describeTabs", "describeTabs",
      [
        ["in", "parameters", ["::SOAP::SOAPElement", "urn:partner.soap.sforce.com", "describeTabs"]],
        ["out", "parameters", ["::SOAP::SOAPElement", "urn:partner.soap.sforce.com", "describeTabsResponse"]]
      ],
      "", nil, :document
    ],
    ["create", "create",
      [
        ["in", "parameters", ["::SOAP::SOAPElement", "urn:partner.soap.sforce.com", "create"]],
        ["out", "parameters", ["::SOAP::SOAPElement", "urn:partner.soap.sforce.com", "createResponse"]]
      ],
      "", nil, :document
    ],
    ["update", "update",
      [
        ["in", "parameters", ["::SOAP::SOAPElement", "urn:partner.soap.sforce.com", "update"]],
        ["out", "parameters", ["::SOAP::SOAPElement", "urn:partner.soap.sforce.com", "updateResponse"]]
      ],
      "", nil, :document
    ],
    ["delete", "delete",
      [
        ["in", "parameters", ["::SOAP::SOAPElement", "urn:partner.soap.sforce.com", "delete"]],
        ["out", "parameters", ["::SOAP::SOAPElement", "urn:partner.soap.sforce.com", "deleteResponse"]]
      ],
      "", nil, :document
    ],
    ["retrieve", "retrieve",
      [
        ["in", "parameters", ["::SOAP::SOAPElement", "urn:partner.soap.sforce.com", "retrieve"]],
        ["out", "parameters", ["::SOAP::SOAPElement", "urn:partner.soap.sforce.com", "retrieveResponse"]]
      ],
      "", nil, :document
    ],
    ["convertLead", "convertLead",
      [
        ["in", "parameters", ["::SOAP::SOAPElement", "urn:partner.soap.sforce.com", "convertLead"]],
        ["out", "parameters", ["::SOAP::SOAPElement", "urn:partner.soap.sforce.com", "convertLeadResponse"]]
      ],
      "", nil, :document
    ],
    ["getDeleted", "getDeleted",
      [
        ["in", "parameters", ["::SOAP::SOAPElement", "urn:partner.soap.sforce.com", "getDeleted"]],
        ["out", "parameters", ["::SOAP::SOAPElement", "urn:partner.soap.sforce.com", "getDeletedResponse"]]
      ],
      "", nil, :document
    ],
    ["getUpdated", "getUpdated",
      [
        ["in", "parameters", ["::SOAP::SOAPElement", "urn:partner.soap.sforce.com", "getUpdated"]],
        ["out", "parameters", ["::SOAP::SOAPElement", "urn:partner.soap.sforce.com", "getUpdatedResponse"]]
      ],
      "", nil, :document
    ],
    ["query", "query",
      [
        ["in", "parameters", ["::SOAP::SOAPElement", "urn:partner.soap.sforce.com", "query"]],
        ["out", "parameters", ["::SOAP::SOAPElement", "urn:partner.soap.sforce.com", "queryResponse"]]
      ],
      "", nil, :document
    ],
    ["queryMore", "queryMore",
      [
        ["in", "parameters", ["::SOAP::SOAPElement", "urn:partner.soap.sforce.com", "queryMore"]],
        ["out", "parameters", ["::SOAP::SOAPElement", "urn:partner.soap.sforce.com", "queryMoreResponse"]]
      ],
      "", nil, :document
    ],
    ["search", "search",
      [
        ["in", "parameters", ["::SOAP::SOAPElement", "urn:partner.soap.sforce.com", "search"]],
        ["out", "parameters", ["::SOAP::SOAPElement", "urn:partner.soap.sforce.com", "searchResponse"]]
      ],
      "", nil, :document
    ],
    ["getServerTimestamp", "getServerTimestamp",
      [
        ["in", "parameters", ["::SOAP::SOAPElement", "urn:partner.soap.sforce.com", "getServerTimestamp"]],
        ["out", "parameters", ["::SOAP::SOAPElement", "urn:partner.soap.sforce.com", "getServerTimestampResponse"]]
      ],
      "", nil, :document
    ],
    ["setPassword", "setPassword",
      [
        ["in", "parameters", ["::SOAP::SOAPElement", "urn:partner.soap.sforce.com", "setPassword"]],
        ["out", "parameters", ["::SOAP::SOAPElement", "urn:partner.soap.sforce.com", "setPasswordResponse"]]
      ],
      "", nil, :document
    ],
    ["resetPassword", "resetPassword",
      [
        ["in", "parameters", ["::SOAP::SOAPElement", "urn:partner.soap.sforce.com", "resetPassword"]],
        ["out", "parameters", ["::SOAP::SOAPElement", "urn:partner.soap.sforce.com", "resetPasswordResponse"]]
      ],
      "", nil, :document
    ],
    ["getUserInfo", "getUserInfo",
      [
        ["in", "parameters", ["::SOAP::SOAPElement", "urn:partner.soap.sforce.com", "getUserInfo"]],
        ["out", "parameters", ["::SOAP::SOAPElement", "urn:partner.soap.sforce.com", "getUserInfoResponse"]]
      ],
      "", nil, :document
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
    Methods.each do |name_as, name, params, soapaction, namespace, style|
      qname = XSD::QName.new(namespace, name_as)
      if style == :document
        @proxy.add_document_method(soapaction, name, params)
        add_document_method_interface(name, params)
      else
        @proxy.add_rpc_method(qname, soapaction, name, params)
        add_rpc_method_interface(name, params)
      end
      if name_as != name and name_as.capitalize == name.capitalize
        ::SOAP::Mapping.define_singleton_method(self, name_as) do |*arg|
          __send__(name, *arg)
        end
      end
    end
  end
end

