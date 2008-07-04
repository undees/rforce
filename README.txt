= rforce

* http://rforce.rubyforge.org

== DESCRIPTION:

RForce is a simple, usable binding to the SalesForce API.

== FEATURES/PROBLEMS:

Rather than enforcing adherence to the sforce.com schema, RForce assumes you are familiar with the API. Ruby method names become SOAP method names. Nested Ruby hashes become nested XML elements.

== SYNOPSIS:

binding = RForce::Binding.new 'na1-api.salesforce.com'
  binding.login 'username', 'password'
  answer = binding.search(
    :searchString =>
      'find {Some Account Name} in name fields returning account(id)')
  account_id = answer.searchResponse.result.searchRecords.record.Id

  opportunity = {
    :accountId => account_id,
    :amount => "10.00",
    :name => "New sale",
    :closeDate => "2005-09-01",
    :stageName => "Closed Won"
  }

  binding.create 'sObject {"xsi:type" => "Opportunity"}' => opportunity
  
== REQUIREMENTS:

* A SalesForce Enterprise or Developer account

== INSTALL:

* sudo gem install rforce

== LICENSE:

Copyright (c) 2005-2008 Ian Dees

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.