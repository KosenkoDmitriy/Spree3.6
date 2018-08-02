$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "affiliate_engine/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "affiliate_engine"
  s.version     = AffiliateEngine::VERSION
  s.authors     = "mark vanderstay"
  s.email       = "mark@soulpad.co.uk"
  s.homepage    = "http://soulpad.co.uk"
  s.summary     = "Allows adding of affiliate and offers"
  s.description = ""

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency('rails', '~> 3.2.13')
  s.add_dependency('paperclip', '~>3.0')
  s.add_dependency('spree_core', '>= 0.50.2')
  s.add_dependency('geocoder', '~> 1.3.2')
  s.add_dependency('gmaps4rails', '~> 2.1.2')
  s.add_dependency('fog', '~> 1.38.0')
  s.add_dependency('ransack', '~>1.1.0')

end
