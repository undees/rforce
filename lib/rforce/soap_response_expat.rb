require 'xml/parser'
require 'rforce/soap_pullable'

module RForce
  class SoapResponseExpat
    include SoapPullable

    def initialize(content)
      @content = content
    end

    def parse
      @current_value = nil
      @stack = []
      @parsed = OpenHash.new({})
      @done = false
      @namespaces = []

      XML::Parser.new.parse(@content) do |type, name, data|
        case type
        when XML::Parser::START_ELEM then
          tag_start name, data
        when XML::Parser::CDATA then
          text data
        when XML::Parser::END_ELEM then
          tag_end name
        end

        break if @done
      end

      @parsed
    end
  end
end
