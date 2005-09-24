require 'defaultDriver.rb'
require 'soap/header/simplehandler'
require 'orderedhash'
 	
class SessionHeaderHandler < SOAP::Header::SimpleHandler

  HeaderName = XSD::QName.new('urn:partner.soap.sforce.com', 'SessionHeader')

  attr_accessor :sessionid

  def initialize
    super(HeaderName)
    @sessionid = nil
  end

  def on_simple_outbound
    if @sessionid
      {'sessionId' => @sessionid}
    else
      nil       # no header
    end
  end
end

class CallOptionsHandler < SOAP::Header::SimpleHandler

  HeaderName = XSD::QName.new('urn:partner.soap.sforce.com', 'CallOptions')

  attr_accessor :client

  def initialize
    super(HeaderName)
    @client = nil
  end

  def on_simple_outbound
    if @client
      {'client' => @client}
    else
      nil       # no header
    end
  end
end
