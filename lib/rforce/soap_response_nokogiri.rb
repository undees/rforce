require 'nokogiri'

module RForce
  class SoapResponseNokogiri
    def initialize(content)
      @content = content
    end

    def parse
      doc = Nokogiri::XML(@content)
      body = doc.at_xpath("//soapenv:Body")
      to_hash(body)
    end

    private
    def to_hash(node)
      if node.text?
        stripped = node.text.strip
        return stripped.empty? ? nil : stripped
      end

      children = node.children.reject {|c| c.text? && c.text.strip.empty? }

      return nil if children.empty?

      return children.first.text.strip if children.first.text?

      elements = MethodHash.new

      
      children.each do |elem|
        
        name = elem.name.split(":").last.to_sym
        
        if !elements[name]
          elements[name] = to_hash(elem)
        elsif Array === elements[name]
          elements[name] << to_hash(elem)
        else
        
          # Salesforce xml sometimes contains the object id Twice 
          next if elem.name == "Id" 
          elements[name] = [elements[name]] << to_hash(elem)
        
        end
        
      end
      
      return elements.empty? ? nil : elements
    end
  end
end
