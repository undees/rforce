# -*- ruby -*-

$:.unshift './lib'

require 'rubygems'
require 'hoe'
require 'rforce/version'

Hoe.new('rforce', RForce::VERSION) do |p|
  p.developer         'Ian Dees', 'undees@gmail.com'
  p.extra_deps      = [['builder', '>= 2.0.0'], ['facets', '>= 2.4']]
  p.extra_dev_deps  = [['rspec', '>= 1.3']]
  p.remote_rdoc_dir = ''
  p.rspec_options   = ['-rubygems', '--options', 'spec/spec.opts']
end

Dir['tasks/**/*.rake'].each { |rake| load rake }

# vim: syntax=Ruby
