begin; require 'rforce/soap_response_nokogiri'; rescue LoadError; end
require 'rforce/soap_response_rexml'


module RForce
  # Use the fastest XML parser available.
  SoapResponse =
    (RForce::const_get(:SoapResponseNokogiri) rescue nil) ||
    SoapResponseRexml
end
