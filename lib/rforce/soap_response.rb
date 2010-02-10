begin; require 'rforce/soap_response_hpricot'; rescue LoadError; end
begin; require 'rforce/soap_response_expat';   rescue LoadError; end
require 'rforce/soap_response_rexml'


module RForce
  # Use the fastest XML parser available.
  SoapResponse =
    (RForce::const_get(:SoapResponseExpat) rescue nil)   ||
    (RForce::const_get(:SoapResponseHpricot) rescue nil) ||
    SoapResponseRexml
end
