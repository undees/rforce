require 'net/https'
require 'rexml/document'
require 'rexml/xpath'
require 'rubygems'
require_gem 'builder'

=begin
  RForce v0.1
  Copyright (c) 2005 Ian Dees

  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files (the "Software"), to deal
  in the Software without restriction, including without limitation the rights
  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice shall be included in
  all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
  SOFTWARE.
=end

#  RForce is a simple Ruby binding to the SalesForce CRM system.
#  Rather than enforcing adherence to the sforce.com schema,
#  RForce assumes you are familiar with the API.  Ruby method names
#  become SOAP method names.  Nested Ruby hashes become nested
#  XML elements.  
#  
#  Example:
#
#    binding = RForce::Binding.new 'na1-api.salesforce.com'
#    binding.login 'username', 'password'
#    answer = binding.search(
#      :searchString =>
#        'find {Some Account Name} in name fields returning account(id)')
#    account_id = answer.searchResponse.result.searchRecords.record.Id
#
#    opportunity = {
#      :accountId => account_id,
#      :amount => "10.00",
#      :name => "New sale",
#      :closeDate => "2005-09-01",
#      :stageName => "Closed Won"
#    }
#
#    binding.create 'sObject {"xsi:type" => "Opportunity"}' => opportunity
#
module RForce

  #Allows indexing hashes like method calls: hash.key
  #to supplement the traditional way of indexing: hash[key]
  module FlashHash
    def method_missing(method, *args)
      self[method]
    end
  end

  #Turns an XML response from the server into a Ruby
  #object whose methods correspond to nested XML elements.
  class SoapResponse
    include FlashHash

    #Parses an XML string into structured data.
    def initialize(content)
      document = REXML::Document.new content
      node = REXML::XPath.first document, '//soapenv:Body'
      @parsed = SoapResponse.parse node
    end

    #Allows this object to act like a hash (and therefore
    #as a FlashHash via the include above).
    def [](symbol)
      @parsed[symbol]
    end
  
    #Digests an XML DOM node into nested Ruby types.
    def SoapResponse.parse(node)
      #Convert text nodes into simple strings.
      return node.text unless node.has_elements?

      #Convert nodes with children into FlashHashes.
      elements = {}
      class << elements
        include FlashHash
      end
    
      #Add all the element's children to the hash.
      node.each_element do |e|
        name = e.name.to_sym
        
        case elements[name]
          #The most common case: unique child element tags.
          when NilClass: elements[name] = parse(e)
          
          #Non-unique child elements become arrays:
          
          #We've already created the array: just
          #add the element.
          when Array: elements[name] << parse(e)
          
          #We haven't created the array yet: do so,
          #then put the existing element in, followed
          #by the new one.
          else
            elements[name] = [elements[name]]
            elements[name] << parse(e)
        end
      end
    
      return elements
    end
  end

  #Implements the connection to the SalesForce server.
  class Binding
    #Fill in the guts of this typical SOAP envelope
    #with the session ID and the body of the SOAP request.
    Envelope = <<-HERE
<?xml version="1.0" encoding="utf-8" ?>
<env:Envelope xmlns:xsd="http://www.w3.org/2001/XMLSchema"
    xmlns:env="http://schemas.xmlsoap.org/soap/envelope/"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <env:Header>
    <SessionHeader>
      <sessionId>%s</sessionId>
    </SessionHeader>
  </env:Header>
  <env:Body>
    %s
  </env:Body>
</env:Envelope>
    HERE

    #Connect to the server securely.
    def initialize(url)
      @server = Net::HTTP.new url, 443
      @server.use_ssl = true
      @session_id = ''
    end
  
    #Log in to the server and remember the session ID
    #returned to us by SalesForce.
    def login(user, pass)
      response = call_remote(:login, [:username, user, :password, pass])

      raise 'Incorrect user name / password' unless response.loginResponse
      @session_id = response.loginResponse.result.sessionId
      response
    end
  
    #Call a method on the remote server.  Arguments can be
    #a hash or (if order is important) an array of alternating
    #keys and values.
    def call_remote(method, args)
      #Create XML text from the arguments.
      expanded = ''
      @builder = Builder::XmlMarkup.new(:target => expanded)
      expand({method => args}, 'urn:enterprise.soap.sforce.com')

      #Fill in the blanks of the SOAP envelope with our
      #session ID and the expanded XML of our request.
      request = (Envelope % [@session_id, expanded])

      #Send the request to the server and read the response.    
      response = @server.post2('/services/Soap/c/6.0', request, {'SOAPAction' => ''})
      SoapResponse.new(response.body)
    end
  
    #Turns method calls on this object into remote SOAP calls.
    def method_missing(method, *args)
      unless args.size == 1 && [Hash, Array].include?(args[0].class)
        raise 'Expected 1 Hash or Array argument'
      end

      call_remote method, args[0]    
    end
  
    #Expand Ruby data structures into XML.
    def expand(args, xmlns = nil)
      #Nest arrays: [:a, 1, :b, 2] => [[:a, 1], [:b, 2]]
      if (args.class == Array)
        args.each_index{|i| args[i, 2] = [args[i, 2]]}
      end
    
      args.each do |key, value|
        attributes = xmlns ? {:xmlns => xmlns} : {}

		#If the XML tag requires attributes,
		#the tag name will contain a space
		#followed by a string representation
		#of a hash of attributes.
		#
		#e.g. 'sObject {"xsi:type" => "Opportunity"}'
		#becomes <sObject xsi:type="Opportunity>...</sObject>
        if key.is_a? String
           key, modifier = key.split(' ', 2)
           attributes.merge!(eval(modifier))
        end
        
        #Create an XML element and fill it with this
        #value's sub-items.
        case value
          when Hash, Array
            @builder.tag!(key, attributes) do expand value; end
          
          when String
            @builder.tag!(key) {@builder.text! value}
        end
      end
    end
  end
end
