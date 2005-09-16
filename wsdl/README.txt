First install the latest versions of http-access2 and soap4r (including
the wsdl2ruby.rb script).

The included files are for the sforce partner WSDL file.  The intent is
to make this suffice for all environments, but in case you need to
modify the default.rb and defaultDriver.rb file for your particular
site's enterprise WSDL, the process is as follows:

Download your wsdl file from the salesforce site (partner or
enterprise wsdl okay).

Then run the following command:

    wsdl2ruby.rb --classdef --driver --wsdl <downloaded file>

This will create two files: <tt>default.rb</tt> and
<tt>defaultDriver.rb</tt>.  The former contains the class definitions
you will need to interface with the SForce API, and the latter contains
the lower level SOAP drivers.

You will also need a ca.pem and soap/property file to get ssl to work
(the included ca.pem came from [NaHi's example](http://dev.ctor.org/soap4r/changeset/1605)).
