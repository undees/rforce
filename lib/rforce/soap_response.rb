require 'rexml/document'
require 'rexml/xpath'
require 'rforce/soap_pullable'


module RForce
  # Turns an XML response from the server into a Ruby
  # object whose methods correspond to nested XML elements.
  class SoapResponse
    include MethodKeys
    include SoapPullable

    %w(attlistdecl cdata comment doctype doctype_end elementdecl
       entity entitydecl instruction notationdecl xmldecl).each do |unused|
      define_method(unused) {}
    end

    # Parses an XML string into structured data.
    def initialize(content)
      @current_value = nil
      @stack = []
      @parsed = {}
      @done = false
      @namespaces = []

      REXML::Document.parse_stream content, self
    end

    # Allows this object to act like a hash (and therefore
    # via MethodKeys from the include above).
    def [](symbol)
      @parsed[symbol]
    end
  end
end
