=begin
Copyright (c) 2005-2010 Ian Dees and contributors

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
=end

#  RForce is a simple Ruby binding to the SalesForce CRM system.
#  Rather than enforcing adherence to the sforce.com schema,
#  RForce assumes you are familiar with the API.  Ruby method names
#  become SOAP method names.  Nested Ruby hashes become nested
#  XML elements.
#
#  Example:
#
#    binding = RForce::Binding.new 'https://www.salesforce.com/services/Soap/u/10.0'
#    binding.login 'username', 'password'
#    answer = binding.search(
#      :searchString =>
#        'find {Some Account Name} in name fields returning account(id)')
#    account_id = answer.searchResponse.result.searchRecords.record.Id
#
#    opportunity = {
#      :accountId => account_id,
#      :amount => "10.00",
#      :name => "New sale",
#      :closeDate => "2005-09-01",
#      :stageName => "Closed Won"
#    }
#
#    binding.create 'sObject {"xsi:type" => "Opportunity"}' => opportunity
#

require 'rforce/binding'
require 'rforce/soap_response'

module RForce
  # Expand Ruby data structures into XML.
  def expand(builder, args, xmlns = nil)
    # Nest arrays: [:a, 1, :b, 2] => [[:a, 1], [:b, 2]]
    if (args.class == Array)
      args.each_index{|i| args[i, 2] = [args[i, 2]]}
    end

    args.each do |key, value|
      attributes = xmlns ? {:xmlns => xmlns} : {}

      # If the XML tag requires attributes,
      # the tag name will contain a space
      # followed by a string representation
      # of a hash of attributes.
      #
      # e.g. 'sObject {"xsi:type" => "Opportunity"}'
      # becomes <sObject xsi:type="Opportunity>...</sObject>
      if key.is_a? String
        key, modifier = key.split(' ', 2)

        attributes.merge!(eval(modifier)) if modifier
      end

      # Create an XML element and fill it with this
      # value's sub-items.
      case value
      when Hash, Array then
        builder.tag!(key, attributes) do expand builder, value; end

      when String then
        builder.tag!(key, attributes) { builder.text! value }
      end
    end
  end
end
