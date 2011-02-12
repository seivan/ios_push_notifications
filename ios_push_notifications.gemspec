# -*- encoding: utf-8 -*-
VERSION = "0.6"

Gem::Specification.new do |s|
  s.name        = "ios_push_notifications"
  s.version     = VERSION
  s.author      = "Seivan Heidari"
  s.email       = "seivan@kth.se"
  s.homepage    = "http://github.com/seivan/ios_push_notifications"
  s.summary     = "Push Notification gem for Rails 3 with proper tests and documentation"
  s.description = "Nicely documented Push Notification gem for rails 3 applications, has generators for migrations and an initializer with configuration. It is well documented and tested.... compared to other shitty forks out there >_>"

  s.files        = Dir["{lib,test}/**/*", "[A-Z]*"]
  s.require_path = "lib"

  s.add_development_dependency 'rails', '~> 3.0.0'
  s.add_development_dependency 'sqlite3-ruby', '~> 1.3.1'

  s.rubyforge_project = s.name
  s.required_rubygems_version = ">= 1.3.4"
end
