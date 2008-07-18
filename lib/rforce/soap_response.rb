require 'rexml/document'
require 'rexml/xpath'


module RForce
  # Turns an XML response from the server into a Ruby
  # object whose methods correspond to nested XML elements.
  class SoapResponse
    include FlashHash
    
    # Parses an XML string into structured data.
    def initialize(content)
      document = REXML::Document.new content
      node = REXML::XPath.first document, '//soapenv:Body'
      @parsed = SoapResponse.parse node
    end

    # Allows this object to act like a hash (and therefore
    # as a FlashHash via the include above).
    def [](symbol)
      @parsed[symbol]
    end

    # Digests an XML DOM node into nested Ruby types.
    def SoapResponse.parse(node)
      # Convert text nodes into simple strings.
      return node.text unless node.has_elements?

      # Convert nodes with children into FlashHashes.
      elements = {}
      class << elements
        include FlashHash
      end

      # Add all the element's children to the hash.
      node.each_element do |e|
        name = e.name.to_sym

        case elements[name]
          # The most common case: unique child element tags.
        when NilClass: elements[name] = parse(e)

          # Non-unique child elements become arrays:

          # We've already created the array: just
          # add the element.
        when Array: elements[name] << parse(e)

          # We haven't created the array yet: do so,
          # then put the existing element in, followed
          # by the new one.
        else
          elements[name] = [elements[name]]
          elements[name] << parse(e)
        end
      end

      return elements
    end
  end
end
