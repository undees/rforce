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
      return parse_text(text) if node.text?

      children = node.children.reject {|c| c.text? && c.text.strip.empty? }

      return nil if children.empty?

      if (child = children.first).text?
        return parse_text(child.text)
      end

      elements = MethodHash.new

      
      children.each do |elem|
        
        name = elem.name.split(":").last.to_sym

        if !elements[name]
          # anything inside 'records' should be an array
          elements[name] = elem.name == 'records' ? [to_hash(elem)] : to_hash(elem)
        elsif Array === elements[name]
          elements[name] << to_hash(elem)
        else
          next if elem.name == "Id" # Id fields are duplicated
          elements[name] = [elements[name]] << to_hash(elem)
        
        end
        
      end

      return elements.empty? ? nil : elements
    end

    def parse_text(text)
      text.strip!

      return nil if text.empty?

      text = Integer(text) rescue text # parse numbers

      boolean?(text) ? boolean(text) : text
    end

    def boolean(string)
      string == "true"
    end

    def boolean?(string)
      %w{true false}.include?(string)
    end
  end
end
