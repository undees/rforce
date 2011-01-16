# -*- ruby -*-
require 'rubygems'
gem 'hoe', '>= 2.1.0'
require 'hoe'

Hoe.spec 'rforce' do
  developer('Ian Dees', 'undees@gmail.com')
  
  self.extra_deps << ['builder', '~> 2.0']
  self.extra_deps << ['oauth', '~> 0.4']

  self.extra_dev_deps << ['rspec', '~> 1.3']

  self.rdoc_locations = ['undees@rforce.rubyforge.org:/var/www/gforge-projects/rforce']
  self.remote_rdoc_dir = ''

  self.rspec_options = ['-rubygems', '--options', 'spec/spec.opts']
end

# vim: syntax=Ruby
