= rforce

* http://rforce.rubyforge.org
* http://rubyforge.org/projects/rforce
* http://bitbucket.org/undees/rforce
* http://github.com/undees/rforce

== DESCRIPTION:

RForce is a simple, usable binding to the SalesForce API.

== FEATURES/PROBLEMS:

Rather than enforcing adherence to the sforce.com schema, RForce assumes you are familiar with the API. Ruby method names become SOAP method names. Nested Ruby hashes become nested XML elements.

== SYNOPSIS:

  binding = RForce::Binding.new \
    'https://www.salesforce.com/services/Soap/u/10.0'

  binding.login \
    'email', 'password_with_token'

  answer = binding.search \
    :searchString =>
      'find {McFakerson Co} in name fields returning account(id)'

  account = answer.searchResponse.result.searchRecords.record
  account = account.first if account.is_a? Array  

  account_id = account.Id
  account_id = account_id.first if account_id.is_a? Array

  opportunity = [
                 :type, 'Opportunity',
                 :accountId, account_id,
                 :amount, '10.00',
                 :name, 'Fakey McFakerson',
                 :closeDate, '2008-07-04',
                 :stageName, 'Closed Won'
                ]

  binding.create :sObject => opportunity
  
== REQUIREMENTS:

* Builder gem
* A SalesForce Enterprise or Developer account

== INSTALL:

* sudo gem install rforce

== LICENSE:

Copyright (c) 2005-2009 Ian Dees and contributors

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
