require File.dirname(__FILE__) + '/spec_helper.rb'
require 'pp'

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
end

describe SoapResponse do
  before :all do
    fname = File.join(File.dirname(__FILE__), 'soap-response.xml')
    @contents = File.open(fname) {|f| f.read}

    @rexml_recs, @expat_recs, @hpricot_recs =
        [SoapResponse, SoapResponseExpat, SoapResponseHpricot].map do |klass|
      results = klass.new(@contents)
      results[:queryResponse][:result][:records]
    end
  end

  it 'turns XML into objects' do
    @rexml_recs.size.should == 58
    @rexml_recs.first.keys.size.should == 99
  end
  
  it 'loosely matches the expat results' do
    @expat_recs.size.should == @rexml_recs.size
    @hpricot_recs.size.should == @rexml_recs.size

    @rexml_recs.each_with_index do |rexml_rec, index|
      expat_rec = @expat_recs[index]
      hpricot_rec = @hpricot_recs[index]

      expat_rec[:Id].inspect.should == rexml_rec[:Id].inspect

      hpricot_rec[:Id].each do |hid|
        hid.inspect.should == rexml_rec[:Id].inspect
      end
      
      rexml_rec.keys.should == expat_rec.keys
      rexml_rec.keys.should == hpricot_rec.keys
      rexml_rec.each do |key|
        unless key == :Id
          rexml_rec[key].should == expat_rec[key]
          rexml_rec[key].should == hpricot_rec[key]
        end
      end
    end
  end
  
  it 'exactly matches the expat results' do
    pending 'Still have to work out Id tags' do
      @rexml_recs.should == @expat_recs
      @rexml_recs.should == @hpricot_recs
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

