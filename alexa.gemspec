$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "alexa/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "alexa-rails"
  s.version     = Alexa::VERSION
  s.authors     = ["Sri Vishnu Totakura"]
  s.email       = ["srivishnu@totakura.in"]
  s.homepage    = "https://github.com/tsrivishnu/alexa-rails"
  s.summary     = "Summary of Alexa."
  s.description = "Description of Alexa."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.1.4"

  s.add_development_dependency "pg"
end
