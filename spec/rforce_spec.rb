require File.dirname(__FILE__) + '/spec_helper.rb'
require 'pp'

describe FlashHash do
  it 'lets you access hash keys with methods' do
    h = {:foo => :bar}
    class << h; include FlashHash; end

    h.foo.should == :bar
    h.nonexistent.should be_nil
  end
end

describe 'expand' do
  it 'turns Ruby into XML' do
    xmlns = 'urn:partner.soap.sforce.com'

#     'sObject {"xsi:type" => "Opportunity"}'
    
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

describe SoapResponse do
  before :all do
    fname = File.join(File.dirname(__FILE__), 'soap-response.xml')
    @contents = File.open(fname) {|f| f.read}

    @rexml_recs, @expat_recs = [SoapResponse, SoapResponseExpat].map do |klass|
      results = klass.new(@contents)
      results[:queryResponse][:result][:records]
    end
    
  end

  it 'turns XML into objects' do
    @rexml_recs.size.should == 58
  end
  
  it 'loosely matches the expat results' do
    @expat_recs.size.should == @rexml_recs.size
    @rexml_recs.each_with_index do |rexml_rec, index|
      expat_rec = @expat_recs[index]
      rexml_rec[:Id].each do |id|
        id.should == expat_rec[:Id]
      end
      
      rexml_rec.keys.should == expat_rec.keys
      rexml_rec.each do |key|
        unless key == :Id
          rexml_rec[key].should == expat_rec[key]
        end
      end
    end
  end
  
  it 'exactly matches the expat results' do
    pending 'Still have to work out Id tags' do
      @rexml_recs.should == @expat_recs
    end
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

