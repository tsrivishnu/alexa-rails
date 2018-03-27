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
  s.summary     = "Serve Alexa skills with your rails app as backend"
  s.description = "The gem adds additional capabilities to your rails app to "\
    "serve as a backend for your Alexa skill by providing routing, "\
    "controllers, views and structure to easily develop and maintain "\
    "skills' backend"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.1.4"

  s.add_development_dependency "pg"
end
