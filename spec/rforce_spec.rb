require 'spec_helper'

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
end

describe 'a SoapResponse implementation' do
  before :all do
    fname = File.join(File.dirname(__FILE__), 'soap-response.xml')
    @contents = File.open(fname) {|f| f.read}

    [:rexml, :expat, :hpricot].each do |processor|
      name = "SoapResponse#{processor.to_s.capitalize}"
      variable = "@#{processor}_recs"

      results = begin
        klass = RForce.const_get name
        klass.new(@contents).parse.queryResponse.result.records
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

  it 'returns the same results with expat' do
    pending 'duplicate <Id> tags'
    @expat_recs.should == @rexml_recs
  end

  it 'returns the same results with hpricot' do
    pending 'duplicate <Id> tags'
    @hpricot_recs.should == @rexml_recs
  end

  it 'returns similar results with expat' do
    pending 'expat not installed' unless @expat_recs
    @expat_recs.should resemble(@rexml_recs)
  end

  it 'returns similar results with hpricot' do
    pending 'hpricot not installed' unless @hpricot_recs
    @hpricot_recs.should resemble(@rexml_recs)
  end

  it 'understands XML entities' do
    expected = "Bee's knees"
    @rexml_recs.first.Description.should == expected

    pending 'expat not installed' unless @expat_recs
    @expat_recs.first.Description.should == expected

    pending 'hpricot not installed' unless @hpricot
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
