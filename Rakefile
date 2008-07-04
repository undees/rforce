# -*- ruby -*-

require 'rubygems'
require 'hoe'
require './lib/rforce.rb'

Hoe.new('rforce', RForce::VERSION) do |p|
  # p.rubyforge_name = 'rforcex' # if different than lowercase project name
  p.developer('Ian Dees', 'undees@gmail.com')
  p.remote_rdoc_dir = ''
end

Dir['tasks/**/*.rake'].each { |rake| load rake }

# vim: syntax=Ruby
