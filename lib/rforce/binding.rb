require 'net/https'
require 'uri'
require 'zlib'
require 'stringio'
require 'rexml/document'
require 'builder'
require 'oauth'

module RForce
  # Implements the connection to the SalesForce server.
  class Binding
    include RForce

    # Increase the maximum fetch size to 2000, as allowed by Salesforce
    # Added by Raymond Gao
    DEFAULT_BATCH_SIZE = 2000
    attr_accessor :batch_size, :url, :assignment_rule_id, :use_default_rule, :update_mru, :client_id, :trigger_user_email,
      :trigger_other_email, :trigger_auto_response_email

    # Fill in the guts of this typical SOAP envelope
    # with the session ID and the body of the SOAP request.
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

    # Connect to the server securely.  If you pass an oauth hash, it
    # must contain the keys :consumer_key, :consumer_secret,
    # :access_token, :access_secret, and :login_url.
    def initialize(url, sid = nil, oauth = nil)
      @session_id = sid
      @oauth = oauth
      @batch_size = DEFAULT_BATCH_SIZE

      init_server(url)
    end


    def show_debug
      ENV['SHOWSOAP'] == 'true'
    end


    def init_server(url)
      @url = URI.parse(url)

      if (@oauth)
        consumer = OAuth::Consumer.new \
          @oauth[:consumer_key],
          @oauth[:consumer_secret],
          { :site => url }

        consumer.http.set_debug_output $stderr if show_debug

        @server  = OAuth::AccessToken.new \
          consumer,
          @oauth[:access_token],
          @oauth[:access_secret]

        class << @server
          alias_method :post2, :post
        end
      else
        @server = Net::HTTP.new(@url.host, @url.port)
        @server.use_ssl = @url.scheme == 'https'
        @server.verify_mode = OpenSSL::SSL::VERIFY_NONE

        # run ruby with -d or env variable SHOWSOAP=true to see SOAP wiredumps.
        @server.set_debug_output $stderr if show_debug
      end
    end


    # Log in to the server with a user name and password, remembering
    # the session ID returned to us by SalesForce.
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

    # Log in to the server with OAuth, remembering
    # the session ID returned to us by SalesForce.
    def login_with_oauth
      result = @server.post @oauth[:login_url], '', {}

      case result
      when Net::HTTPSuccess
        doc = REXML::Document.new result.body
        @session_id = doc.elements['*/sessionId'].text
        server_url  = doc.elements['*/serverUrl'].text
        init_server server_url

        return {:sessionId => @sessionId, :serverUrl => server_url}
      when Net::HTTPUnauthorized
        raise 'Invalid OAuth tokens'
      else
        raise 'Unexpected error: #{response.inspect}'
      end
    end

    # Call a method on the remote server.  Arguments can be
    # a hash or (if order is important) an array of alternating
    # keys and values.
    def call_remote(method, args)

      urn, soap_url = block_given? ? yield : ["urn:partner.soap.sforce.com", @url.path]

      # Create XML text from the arguments.
      expanded = ''
      @builder = Builder::XmlMarkup.new(:target => expanded)
      expand(@builder, {method => args}, urn)

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

      # Fill in the blanks of the SOAP envelope with our
      # session ID and the expanded XML of our request.
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

      # Send the request to the server and read the response.
      response = @server.post2(soap_url, request.lstrip, headers)

      # decode if we have encoding
      content = decode(response)

      # Check to see if INVALID_SESSION_ID was raised and try to relogin in
      if method != :login and @session_id and content =~ /sf:INVALID_SESSION_ID/
        login(@user, @password)

        # repackage and rencode request with the new session id
        request = (Envelope % [@session_id, @batch_size, extra_headers, expanded])
        request = encode(request)

        # Send the request to the server and read the response.
        response = @server.post2(soap_url, request.lstrip, headers)

        content = decode(response)
      end

      SoapResponse.new(content).parse
    end


    # decode gzip
    def decode(response)
      encoding = response['Content-Encoding']

      # return body if no encoding
      if !encoding then return response.body end

      # decode gzip
      case encoding.strip
      when 'gzip' then
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


    # Turns method calls on this object into remote SOAP calls.
    def method_missing(method, *args)
      unless args.size == 1 && [Hash, Array].include?(args[0].class)
        raise 'Expected 1 Hash or Array argument'
      end

      call_remote method, args[0]
    end
  end
end
