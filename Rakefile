# -*- ruby -*-

$:.unshift './lib'
require 'rubygems'
require 'hoe'
require 'rforce/version'

Hoe.new('rforce', RForce::VERSION) do |p|
  p.developer('Ian Dees', 'undees@gmail.com')
  p.extra_deps = [['builder', '>= 2.0.0']]
  p.extra_dev_deps = [['hoe', '>= 1.7.0']]
  p.remote_rdoc_dir = ''
end

Dir['tasks/**/*.rake'].each { |rake| load rake }

# vim: syntax=Ruby
