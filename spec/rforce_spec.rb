require File.dirname(__FILE__) + '/spec_helper.rb'

describe FlashHash do
  it 'lets you access hash keys with methods' do
    h = {:foo => :bar}
    class << h; include FlashHash; end

    h.foo.should == :bar
    h.nonexistent.should be_nil
  end
end
