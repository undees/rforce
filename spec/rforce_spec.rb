require File.dirname(__FILE__) + '/spec_helper.rb'

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

