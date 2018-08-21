$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "features_engine/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "features_engine"
  s.version     = FeaturesEngine::VERSION
  s.authors     =  "mvanderstay"
  s.email       =  "m.van.der.stay@gmail.com"
  s.homepage    = ""
  s.summary     = ": Update of Home Page Features."
  s.description = ": ."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  spree_version = '>= 3.1.0', '< 4.0'
  s.add_dependency 'spree_core', spree_version
  s.add_dependency 'spree_backend', spree_version

  s.add_development_dependency "sqlite3"
end
