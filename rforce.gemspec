# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{rforce}
  s.version = "0.6"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Ian Dees"]
  s.date = %q{2011-01-18}
  s.description = %q{RForce is a simple, usable binding to the SalesForce API.}
  s.email = ["undees@gmail.com"]
  s.extra_rdoc_files = ["History.txt", "Manifest.txt", "README.txt"]
  s.files = ["History.txt", "Manifest.txt", "README.txt", "Rakefile", "lib/rforce.rb", "lib/rforce/binding.rb", "lib/rforce/method_keys.rb", "lib/rforce/soap_pullable.rb", "lib/rforce/soap_response.rb", "lib/rforce/soap_response_expat.rb", "lib/rforce/soap_response_hpricot.rb", "lib/rforce/soap_response_nokogiri.rb", "lib/rforce/soap_response_rexml.rb", "lib/rforce/version.rb", "spec/rforce_spec.rb", "spec/soap-response.xml", "spec/spec.opts", "spec/spec_helper.rb", "tasks/timing.rake"]
  s.homepage = %q{http://rforce.rubyforge.org}
  s.rdoc_options = ["--main", "README.txt"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{rforce}
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{RForce is a simple, usable binding to the SalesForce API.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<builder>, ["~> 2.0"])
      s.add_runtime_dependency(%q<oauth>, ["~> 0.4"])
      s.add_development_dependency(%q<rspec>, ["~> 1.3"])
      s.add_development_dependency(%q<hoe>, [">= 2.8.0"])
    else
      s.add_dependency(%q<builder>, ["~> 2.0"])
      s.add_dependency(%q<oauth>, ["~> 0.4"])
      s.add_dependency(%q<rspec>, ["~> 1.3"])
      s.add_dependency(%q<hoe>, [">= 2.8.0"])
    end
  else
    s.add_dependency(%q<builder>, ["~> 2.0"])
    s.add_dependency(%q<oauth>, ["~> 0.4"])
    s.add_dependency(%q<rspec>, ["~> 1.3"])
    s.add_dependency(%q<hoe>, [">= 2.8.0"])
  end
end
