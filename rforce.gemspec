lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "rforce/version"

Gem::Specification.new do |spec|
  spec.name          = "rforce"
  spec.version       = RForce::VERSION
  spec.authors       = ["Erin Dees"]
  spec.email         = ["undees@gmail.com"]

  spec.summary       = %q{A simple, usable binding to the Salesforce API.}
  spec.homepage      = "https://github.com/undees/rforce"
  spec.license       = "MIT"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/undees/rforce"
  spec.metadata["changelog_uri"] = "https://github.com/undees/rforce/"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features|lib/tasks)/}) }
  end
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "builder", "~> 3.0"
  spec.add_runtime_dependency "oauth", "~> 0.4"

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 12.3.3"
  spec.add_development_dependency "rspec", "~> 3.0"

  # Optional XML parsing engines
  spec.add_development_dependency "nokogiri", "~> 1.10.8"
  spec.add_development_dependency("xmlparser", "~> 0.7") unless RUBY_PLATFORM == 'java'
end
