= rforce

* http://github.com/undees/rforce

== DESCRIPTION:

RForce is a simple, usable binding to the Salesforce API.

{<img src="https://travis-ci.org/undees/rforce.png" />}[https://travis-ci.org/undees/rforce]

== FEATURES:

Rather than enforcing adherence to the sforce.com schema, RForce assumes you are familiar with the API. Ruby method names become SOAP method names. Nested Ruby hashes become nested XML elements.

== SYNOPSIS:

=== Logging in with a user name and password

  binding = RForce::Binding.new \
    'https://www.salesforce.com/services/Soap/u/20.0'

  binding.login \
    'email', 'password' + 'token'

=== Logging in with OAuth

  oauth = {
    :consumer_key    => '...', # Tokens obtained from Salesforce
    :consumer_secret => '...',
    :access_token    => '...',
    :access_secret   => '...',
    :login_url       => 'https://login.salesforce.com/services/OAuth/u/20.0'
  }

  binding = RForce::Binding.new \
    'https://www.salesforce.com/services/Soap/u/20.0',
    nil,
    oauth

  binding.login_with_oauth

=== Finding a record

  answer = binding.search \
    :searchString =>
      'find {McFakerson Co} in name fields returning account(id)'

  account = answer.searchResponse.result.searchRecords.record
  account_id = account.Id

=== Creating a record

  opportunity = [
                 :type,      'Opportunity',
                 :accountId, account_id,
                 :amount,    '10.00',
                 :name,      'Fakey McFakerson',
                 :closeDate, '2008-07-04',
                 :stageName, 'Closed Won'
                ]

  binding.create :sObject => opportunity

== REQUIREMENTS:

* +builder+ and +oauth+ gems
* A Salesforce Enterprise or Developer account

== INSTALL:

* gem install rforce

== LICENSE:

Copyright (c) 2005-2019 Erin Dees and contributors

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
