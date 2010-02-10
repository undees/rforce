require 'rexml/document'
require 'rexml/xpath'
require 'rforce/soap_pullable'


module RForce
  # Turns an XML response from the server into a Ruby
  # object whose methods correspond to nested XML elements.
  class SoapResponseRexml
    include SoapPullable

    %w(attlistdecl cdata comment doctype doctype_end elementdecl
       entity entitydecl instruction notationdecl xmldecl).each do |unused|
      define_method(unused) {|*args|}
    end

    def initialize(content)
      @content = content
    end

    # Parses an XML string into structured data.
    def parse
      @current_value = nil
      @stack = []
      @parsed = OpenHash.new({})
      @done = false
      @namespaces = []

      REXML::Document.parse_stream @content, self

      @parsed
    end
  end
end
