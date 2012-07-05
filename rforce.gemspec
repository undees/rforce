# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "rforce"
  s.version = "0.8.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Ian Dees"]
  s.date = "2012-01-29"
  s.description = "RForce is a simple, usable binding to the Salesforce API."
  s.email = ["undees@gmail.com"]
  s.extra_rdoc_files = ["History.txt", "Manifest.txt", "README.txt"]
  s.files = ["History.txt", "Manifest.txt", "README.txt", "Rakefile", "lib/rforce.rb", "lib/rforce/binding.rb", "lib/rforce/method_keys.rb", "lib/rforce/soap_pullable.rb", "lib/rforce/soap_response.rb", "lib/rforce/soap_response_expat.rb", "lib/rforce/soap_response_hpricot.rb", "lib/rforce/soap_response_nokogiri.rb", "lib/rforce/soap_response_rexml.rb", "lib/rforce/version.rb", "spec/rforce_spec.rb", "spec/soap-response.xml", "spec/spec.opts", "spec/spec_helper.rb", "tasks/timing.rake", ".gemtest"]
  s.homepage = "http://rforce.rubyforge.org"
  s.rdoc_options = ["--main", "README.txt"]
  s.require_paths = ["lib"]
  s.rubyforge_project = "rforce"
  s.rubygems_version = "1.8.10"
  s.summary = "RForce is a simple, usable binding to the Salesforce API."

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<builder>, ["~> 3.0"])
      s.add_runtime_dependency(%q<oauth>, ["~> 0.4"])
      s.add_development_dependency(%q<rspec>, ["~> 2.8"])
      s.add_development_dependency(%q<hoe-gemspec2>, ["~> 1.1"])
      s.add_development_dependency(%q<rdoc>, ["~> 3.10"])
      s.add_development_dependency(%q<hoe>, ["~> 2.13"])
    else
      s.add_dependency(%q<builder>, ["~> 3.0"])
      s.add_dependency(%q<oauth>, ["~> 0.4"])
      s.add_dependency(%q<rspec>, ["~> 2.8"])
      s.add_dependency(%q<hoe-gemspec2>, ["~> 1.1"])
      s.add_dependency(%q<rdoc>, ["~> 3.10"])
      s.add_dependency(%q<hoe>, ["~> 2.13"])
    end
  else
    s.add_dependency(%q<builder>, ["~> 3.0"])
    s.add_dependency(%q<oauth>, ["~> 0.4"])
    s.add_dependency(%q<rspec>, ["~> 2.8"])
    s.add_dependency(%q<hoe-gemspec2>, ["~> 1.1"])
    s.add_dependency(%q<rdoc>, ["~> 3.10"])
    s.add_dependency(%q<hoe>, ["~> 2.13"])
  end
end
