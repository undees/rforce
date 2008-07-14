=begin
RForce v0.2
Copyright (c) 2005-2008 Ian Dees

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


require 'net/https'
require 'uri'
require 'zlib'
require 'stringio'
require 'rexml/document'
require 'rexml/xpath'
require 'xml/parser'
require 'rubygems'
gem 'builder', '>= 2.0.0'
require 'builder'


module RForce
  VERSION = '0.2.1'

  #Allows indexing hashes like method calls: hash.key
  #to supplement the traditional way of indexing: hash[key]
  module FlashHash
    def method_missing(method, *args)
      self[method]
    end
  end

  class SoapResponseExpat
    include FlashHash

    attr_reader :hash_time

    SOAP_ENVELOPE = 'soapenv:Envelope'

    def initialize(content)
      @current_value, @stack, @parsed = nil, [], Hash.new
      
      namespaces = []
      t = Time.now
      
      XML::Parser.new.parse( content ) do |type, name, data|
        # We are not interested in keeping the namespace declarations for the tag
        # names so lets deal with that here.
        unless name.nil?
          if name.index( ':' )
            tag_ns, tag_name = name.split( ':' )
            tag_name = name unless namespaces.include?( tag_ns )
          else
            tag_name = name
          end
        end

        case type
          # name     = The literal tag name of the element
          # tag_name = The name of the element minus the namespace that gets used
          #            as the key in the hash 
          # data     = The attributes of the element
          when XML::Parser::START_ELEM
            # The attribute of the first element is the soap envelope which has
            # as attributes the allowed namespaces of all the tags so lets grab
            # them here to make sure we can strip them out appropriately since
            # they are not necessary in our hash.
            namespaces = data.keys.map { |k| k.split( ':' )[1] if k.match( 'xmlns:' ) }.compact if name.eql?( SOAP_ENVELOPE )
            
            next if tag_name.eql?( SOAP_ENVELOPE )
            
            @stack.push( Hash.new )
            
          # name     = The literal tag name of the element
          # tag_name = The name of the element minus the namespace that gets used
          #            as the key in the hash 
          # data     = The actual data identified by the element
          when XML::Parser::CDATA
            @current_value = data.strip.empty? ? nil : data
            
          # name     = The literal tag name of the element
          # tag_name = The name of the element minus the namespace that gets used
          #            as the key in the hash 
          # data     = nil
          when XML::Parser::END_ELEM
            next if tag_name.eql?( SOAP_ENVELOPE )

            working_hash = @stack.pop

            # We are either done or working on a certain depth in the current
            # stack.
            if @stack.empty?
              @parsed = working_hash
              break
            else
              index = @stack.size - 1
            end

            # working_hash and @current_value have a mutually exclusive relationship.
            # If the current element doesn't have a value then it means that there
            # is a nested data structure.  In this case then working_hash is populated
            # and @current_value is nil.  Conversely, if @current_value has a value
            # then we do not have a nested data sctructure and working_hash will
            # be empty.
            use_value = ( working_hash.empty? ) ? @current_value : working_hash

            if @stack[index].keys.include?( tag_name.to_sym )
              # This is here to handle the Id value being included twice and thus
              # producing an array.  We skip the second instance so the array is
              # not created.
              if tag_name.eql?( 'Id' )
                # If we don't clear out the current value here, then we introduce
                # a bug if the element after this Id should be null.  An example
                # query is the following:
                #
                # Select Id, LeadId, ContactId from CampaignMember...
                #
                # For the members that are Contacts their LeadId will be null.  If
                # we fail to clear out this data the resulting hash would be:
                #
                # { ... :records => [ 
                #   { :Id => '00v50000008pfHrAAI', :LeadId => '00v50000008pfHrAAI', :ContactId => '0035000000KwjIuAAJ' },
                #   { :Id => '00v50000008pfHsAAI', :LeadId => '00v50000008pfHsAAI', :ContactId => '0035000000KwjIvAAJ' },
                # }
                #
                # Now you see the problem.  When the @current_value = nil is present
                # we get the following:
                #
                # { ... :records => [ 
                #   { :Id => '00v50000008pfHrAAI', :LeadId => nil, :ContactId => '0035000000KwjIuAAJ' },
                #   { :Id => '00v50000008pfHsAAI', :LeadId => nil, :ContactId => '0035000000KwjIvAAJ' },
                # }
                #
                # which is correct so don't get the bright idea of removing this
                # line
                @current_value = nil
                next
              end

              # We are here because the name of our current element is one that
              # already exists in the hash.  If this is the first encounter with
              # the duplicate tag_name then we convert the existing value to an
              # array otherwise we push the value we are working with and add it
              # to the existing array.
              if @stack[index][tag_name.to_sym].is_a?( Array )
                @stack[index][tag_name.to_sym] << use_value
              else
                @stack[index][tag_name.to_sym] = [ @stack[index][tag_name.to_sym] ]
                @stack[index][tag_name.to_sym] << use_value
              end
            else
              # We are here because the name of our current element has not been
              # assigned yet.
              @stack[index][tag_name.to_sym] = use_value
            end

            # We are done with the current tag so reset the data for the next one
            @current_value = nil
        end
      end

      @hash_time = Time.now - t

      self
    end

    def [](key)
      @parsed[key.to_sym]
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

  #Expand Ruby data structures into XML.
  def expand(builder, args, xmlns = nil)
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

        attributes.merge!(eval(modifier)) if modifier
      end

      #Create an XML element and fill it with this
      #value's sub-items.
      case value
      when Hash, Array
        builder.tag!(key, attributes) do expand builder, value; end

      when String
        builder.tag!(key, attributes) { builder.text! value }
      end
    end
  end
  
  #Implements the connection to the SalesForce server.
  class Binding
    include RForce
    
    DEFAULT_BATCH_SIZE = 10
    attr_accessor :batch_size, :url, :assignment_rule_id, :use_default_rule, :update_mru, :client_id, :trigger_user_email, 
      :trigger_other_email, :trigger_auto_response_email

    #Fill in the guts of this typical SOAP envelope
    #with the session ID and the body of the SOAP request.
    Envelope = <<-HERE
<?xml version="1.0" encoding="utf-8" ?>
<soap:Envelope xmlns:xsd="http://www.w3.org/2001/XMLSchema"
    xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:partner="urn:partner.soap.sforce.com">
    xmlns:spartner="urn:sobject.partner.soap.sforce.com">
  <soap:Header>
    <partner:SessionHeader soap:mustUnderstand='1'>
      <partner:sessionId>%s</partner:sessionId>
    </partner:SessionHeader>
    <partner:QueryOptions soap:mustUnderstand='1'>
      <partner:batchSize>%d</partner:batchSize>
    </partner:QueryOptions>
    %s
  </soap:Header>
  <soap:Body>
    %s
  </soap:Body>
</soap:Envelope>
    HERE

    AssignmentRuleHeaderUsingRuleId = '<partner:AssignmentRuleHeader soap:mustUnderstand="1"><partner:assignmentRuleId>%s</partner:assignmentRuleId></partner:AssignmentRuleHeader>'
    AssignmentRuleHeaderUsingDefaultRule = '<partner:AssignmentRuleHeader soap:mustUnderstand="1"><partner:useDefaultRule>true</partner:useDefaultRule></partner:AssignmentRuleHeader>'
    MruHeader = '<partner:MruHeader soap:mustUnderstand="1"><partner:updateMru>true</partner:updateMru></partner:MruHeader>'
    ClientIdHeader = '<partner:CallOptions soap:mustUnderstand="1"><partner:client>%s</partner:client></partner:CallOptions>'

    #Connect to the server securely.
    def initialize(url, sid = nil)
      init_server(url)

      @session_id = sid
      @batch_size = DEFAULT_BATCH_SIZE
    end


    def show_debug
      ENV['SHOWSOAP'] == 'true'
    end


    def init_server(url)
      @url = URI.parse(url)
      @server = Net::HTTP.new(@url.host, @url.port)
      @server.use_ssl = @url.scheme == 'https'
      @server.verify_mode = OpenSSL::SSL::VERIFY_NONE

      # run ruby with -d or env variable SHOWSOAP=true to see SOAP wiredumps.
      @server.set_debug_output $stderr if show_debug
    end


    #Log in to the server and remember the session ID
    #returned to us by SalesForce.
    def login(user, password)
      @user = user
      @password = password

      response = call_remote(:login, [:username, user, :password, password])
      
      raise "Incorrect user name / password [#{response.fault}]" unless response.loginResponse

      result = response[:loginResponse][:result]
      @session_id = result[:sessionId]

      init_server(result[:serverUrl])

      response
    end


    #Call a method on the remote server.  Arguments can be
    #a hash or (if order is important) an array of alternating
    #keys and values.
    def call_remote(method, args)
      #Create XML text from the arguments.
      expanded = ''
      @builder = Builder::XmlMarkup.new(:target => expanded)
      expand(@builder, {method => args}, 'urn:partner.soap.sforce.com')

      extra_headers = ""
      extra_headers << (AssignmentRuleHeaderUsingRuleId % assignment_rule_id) if assignment_rule_id
      extra_headers << AssignmentRuleHeaderUsingDefaultRule if use_default_rule
      extra_headers << MruHeader if update_mru
      extra_headers << (ClientIdHeader % client_id) if client_id
      
      if trigger_user_email or trigger_other_email or trigger_auto_response_email
        extra_headers << '<partner:EmailHeader soap:mustUnderstand="1">'
        
        extra_headers << '<partner:triggerUserEmail>true</partner:triggerUserEmail>' if trigger_user_email
        extra_headers << '<partner:triggerOtherEmail>true</partner:triggerOtherEmail>' if trigger_other_email
        extra_headers << '<partner:triggerAutoResponseEmail>true</partner:triggerAutoResponseEmail>' if trigger_auto_response_email
        
        extra_headers << '</partner:EmailHeader>'
      end

      #Fill in the blanks of the SOAP envelope with our
      #session ID and the expanded XML of our request.
      request = (Envelope % [@session_id, @batch_size, extra_headers, expanded])
      
      # reset the batch size for the next request
      @batch_size = DEFAULT_BATCH_SIZE

      # gzip request
      request = encode(request)

      headers = {
        'Connection' => 'Keep-Alive',
        'Content-Type' => 'text/xml',
        'SOAPAction' => '""',
        'User-Agent' => 'activesalesforce rforce/1.0'
      }

      unless show_debug
        headers['Accept-Encoding'] = 'gzip'
        headers['Content-Encoding'] = 'gzip'
      end

      #Send the request to the server and read the response.
      response = @server.post2(@url.path, request.lstrip, headers)

      # decode if we have encoding
      content = decode(response)

      # Check to see if INVALID_SESSION_ID was raised and try to relogin in
      if method != :login and @session_id and content =~ /sf:INVALID_SESSION_ID/
        login(@user, @password)

		#  repackage and rencode request with the new session id
		request = (Envelope % [@session_id, @batch_size, extra_headers, expanded])
		request = encode(request)

        #Send the request to the server and read the response.
        response = @server.post2(@url.path, request.lstrip, headers)

        content = decode(response)
      end

      SoapResponse.new(content)
    end


    # decode gzip
    def decode(response)
      encoding = response['Content-Encoding']

      # return body if no encoding
      if !encoding then return response.body end

      # decode gzip
      case encoding.strip
      when 'gzip':
        begin
          gzr = Zlib::GzipReader.new(StringIO.new(response.body))
          decoded = gzr.read
        ensure
          gzr.close
        end
        decoded
      else
        response.body
      end
    end


    # encode gzip
    def encode(request)
      return request if show_debug

      begin
        ostream = StringIO.new
        gzw = Zlib::GzipWriter.new(ostream)
        gzw.write(request)
        ostream.string
      ensure
        gzw.close
      end
    end


    #Turns method calls on this object into remote SOAP calls.
    def method_missing(method, *args)
      unless args.size == 1 && [Hash, Array].include?(args[0].class)
        raise 'Expected 1 Hash or Array argument'
      end

      call_remote method, args[0]
    end
  end
end
