require 'hpricot'
require 'cgi'


module RForce
  class SoapResponseHpricot
    # Parses an XML string into structured data.
    def initialize(content)
      @content = content
    end

    # Digests an XML DOM node into nested Ruby types.
    def parse
      document = Hpricot.XML(@content)
      node = document % 'soapenv:Body'
      self.class.node_to_ruby node
    end

    private

    def self.unescapeXML(string)
      CGI.unescapeHTML(string).gsub("&apos;", "'")
    end

    def self.node_to_ruby(node)
      # Convert text nodes into simple strings.
      children = (node.children || []).reject do |c|
        c.is_a?(Hpricot::Text) && c.to_s.strip.empty?
      end

      if node.is_a?(Hpricot::Text)
        return SoapResponseHpricot.unescapeXML(node.inspect[1..-2])
      end

      if children.first.is_a?(Hpricot::Text)
        return SoapResponseHpricot.unescapeXML(children.first.inspect[1..-2])
      end

      # Convert nodes with children into MethodHashes.
      elements = OpenHash.new({})

      # Add all the element's children to the hash.
      children.each do |e|
        next if e.is_a?(Hpricot::Text) && e.to_s.strip.empty?
        name = e.name

        if name.include? ':'
          name = name.split(':').last
        end

        name = name.to_sym

        case elements[name]
          # The most common case: unique child element tags.
        when NilClass then elements[name] = node_to_ruby(e)

          # Non-unique child elements become arrays:

          # We've already created the array: just
          # add the element.
        when Array then elements[name] << node_to_ruby(e)

          # We haven't created the array yet: do so,
          # then put the existing element in, followed
          # by the new one.
        else
          elements[name] = [elements[name]]
          elements[name] << node_to_ruby(e)
        end
      end

      return elements.empty? ? nil : elements
    end
  end
end
