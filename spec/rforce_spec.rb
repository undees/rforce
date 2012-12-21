require 'spec_helper'

describe MethodKeys do
  it 'lets you access hash keys with methods' do
    h = {:foo => :bar}
    class << h; include MethodKeys; end

    h.foo.should == :bar
    h.nonexistent.should be_nil
  end

  it 'provides a Hash-like class' do
    mh = MethodHash.new
    mh[:one] = 1
    mh[:ten] = 10

    mh.one.should == 1
    mh.ten.should == 10
    mh.nothing.should be_nil
  end
end

describe 'expand' do
  it 'turns Ruby into XML' do
    xmlns = 'urn:partner.soap.sforce.com'

    expanded = ''
    builder = Builder::XmlMarkup.new(:target => expanded)

    data =
      ['partner:create',
        ['partner:sObjects',
          ['spartner:type', 'Contact',
           'AccountId', '01234567890ABCD',
           'FirstName', 'Jane',
           'LastName', 'Doe'],
         'partner:sObjects',
           ['spartner:type', 'Account',
            'Name', 'Acme Rockets, Inc.']]]

    expand(builder, data)

    expanded.should == CreateXml
  end

  it 'handles duplicate objects without complaint' do
    expanded = ''
    builder  = Builder::XmlMarkup.new(:target => expanded)
    account  = [:type, 'Account', :name, 'ALPHA']
    args     = {:create=> [:sObjects, account, :sObjects, account]}
    urn      = 'urn:partner.soap.sforce.com'

    # should not raise
    expand builder, args, urn
  end
end

describe 'a SoapResponse implementation' do
  before :all do
    fname = File.join(File.dirname(__FILE__), 'soap-response.xml')
    @contents = File.open(fname) {|f| f.read}

    [:rexml, :expat, :hpricot, :nokogiri].each do |processor|
      name     = "SoapResponse#{processor.to_s.capitalize}".to_sym
      variable = "@#{processor}_recs".to_sym

      results = begin
        klass = RForce.const_get name
        klass.new(@contents).parse.queryResponse[:result][:records]
      rescue NameError
        nil
      end

      instance_variable_set(variable, results)
    end
  end

  it 'turns XML into objects' do
    @rexml_recs.size.should == 58
    @rexml_recs.first.keys.size.should == 99
  end

  # Special-case expat tests for CI
  it 'returns the same results with expat' do
    pending 'expat not installed' unless @expat_recs
    @expat_recs.should == @rexml_recs
  end

  it 'returns the same results with hpricot' do
    @hpricot_recs.should == @rexml_recs
  end

  it 'understands XML entities' do
    expected = "Bee's knees"
    @rexml_recs.first.Description.should == expected

    # Special-case expat tests for CI
    if @expat_recs
      @expat_recs.first.Description.should == expected
    end

    @hpricot_recs.first.Description.should == expected
  end
end

describe 'SoapResponseHpricot' do
  it 'parses basic XML entities' do
    text = '&lt;tag attr=&quot;Bee&apos;s knees &amp; toes&quot;&gt;'
    SoapResponseHpricot.unescapeXML(text).should ==
      %q(<tag attr="Bee's knees & toes">)
  end
end

SOAP_WRAPPER = <<-XML
<?xml version="1.0" encoding="UTF-8"?>
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns="urn:partner.soap.sforce.com" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:sf="urn:sobject.partner.soap.sforce.com">
  <soapenv:Body>
    %s
  </soapenv:Body>
</soapenv:Envelope>
XML

shared_examples_for 'a SOAP response' do
  def wrap_in_salesforce_envelope(xml)
    SOAP_WRAPPER % xml
  end

  it 'parses nested elements into nested hashes' do
    xml = wrap_in_salesforce_envelope("""
    <foo>
      <bar>Bin</bar>
    </foo>""")

    klass.new(xml).parse.should == {:foo => {:bar => "Bin"}}
  end

  it 'parses repeated elements into arrays' do
    xml = wrap_in_salesforce_envelope("""
    <foo>
      <bar>Bin</bar>
      <bar>Bash</bar>
    </foo>""")

    klass.new(xml).parse.should == {:foo => {:bar => ["Bin", "Bash"]}}
  end

  it 'parses records with single record as an array' do
    xml = wrap_in_salesforce_envelope("""
    <records>
      <sf:type>Contact</sf:type>
    </records>""")

    klass.new(xml).parse.should == {:records => [{:type => "Contact"}]}
  end

  it 'parses records with multiple records as an array' do
    xml = wrap_in_salesforce_envelope("""
    <records>
      <sf:type>Contact</sf:type>
    </records>
    <records>
      <sf:type>Contact</sf:type>
    </records>""")

    klass.new(xml).parse.should == {:records => [{:type => "Contact"}, {:type => "Contact"}]}
  end

  it 'parses Id array as single string' do
    xml = wrap_in_salesforce_envelope("""
    <foo>
      <sf:Id>some_id</sf:Id>
      <sf:Id>some_id</sf:Id>
    </foo>""")

    klass.new(xml).parse.should == {:foo => {:Id => "some_id"}}
  end

  it 'parses booleans' do
    xml = wrap_in_salesforce_envelope("""
    <foo>
      <size>20</size>
      <done>true</done>
      <more>false</more>
      <string>normal string</string>
    </foo>""")

    klass.new(xml).parse.should == {:foo => {:size => "20", :done => true, :more => false, :string => "normal string"}}
  end

  it 'disregards namespacing when determining hash keys' do
    xml = wrap_in_salesforce_envelope("""
    <soapenv:foo>
      <bar>Bin</bar>
      <soapenv:bar>Bash</soapenv:bar>
    </soapenv:foo>""")

   klass.new(xml).parse.should == {:foo => {:bar => ["Bin", "Bash"]}}
  end

  it 'unescapes any HTML contained in text nodes' do
    xml = wrap_in_salesforce_envelope("""
    <foo>
      <bar>Bin</bar>
      <bar>&lt;tag attr=&quot;Bee&apos;s knees &amp; toes&quot;&gt;</bar>
    </foo>""")

    klass.new(xml).parse()[:foo][:bar].last.should == %q(<tag attr="Bee's knees & toes">)
  end

  it 'returns an object that can be navigated via methods in addition to keys' do
    xml = wrap_in_salesforce_envelope("<foo><bar><bin>bash</bin></bar></foo>")
    klass.new(xml).parse().foo.bar.bin.should == "bash"
  end
end

describe 'SoapResponseNokogiri' do
  it_behaves_like 'a SOAP response' do
    let(:klass) { SoapResponseNokogiri }
  end
end

# Special-case expat tests for CI
if RForce.const_defined? :SoapResponseExpat
  describe 'SoapResponseExpat' do
    it_behaves_like 'a SOAP response' do
      let(:klass) { SoapResponseExpat }
    end
  end
end

describe 'SoapResponseRexml' do
  it_behaves_like 'a SOAP response' do
    let(:klass) { SoapResponseRexml }
  end
end

describe 'SoapResponseHpricot' do
  it_behaves_like 'a SOAP response' do
    let(:klass) { SoapResponseHpricot }
  end
end

CreateXml = <<HERE.gsub(/\n\s*/, '')
<partner:create>
  <partner:sObjects>
    <spartner:type>Contact</spartner:type>
    <AccountId>01234567890ABCD</AccountId>
    <FirstName>Jane</FirstName>
    <LastName>Doe</LastName>
  </partner:sObjects>
  <partner:sObjects>
    <spartner:type>Account</spartner:type>
    <Name>Acme Rockets, Inc.</Name>
  </partner:sObjects>
</partner:create>
HERE
