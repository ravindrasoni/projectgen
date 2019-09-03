lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "cookiegen/version"

Gem::Specification.new do |spec|
  spec.name          = "cookiegen"
  spec.version       = CookieGen::VERSION
  spec.authors       = ["Ravindra Soni"]
  spec.email         = ["soni@nickelfox.com"]

  spec.summary       = %q{Generate cookiecutters from templates}
  spec.description   = %q{Generate cookiecutters from templates. Use a json file to definer mapping and that's it}
  spec.homepage      = "http://github.com/ravindrasoni/cookiegen"
  spec.license       = "MIT"

  # spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "http://github.com/ravindrasoni/cookiegen"
  spec.metadata["changelog_uri"] = "http://github.com/ravindrasoni/cookiegen"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.2"
  spec.add_dependency "thor"
end
