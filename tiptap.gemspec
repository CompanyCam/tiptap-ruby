# frozen_string_literal: true

require_relative "lib/tip_tap/version"

Gem::Specification.new do |spec|
  spec.name = "tiptap-ruby"
  spec.version = TipTap::VERSION
  spec.authors = ["Chad Wilken"]
  spec.email = ["chad.wilken@gmail.com"]

  spec.summary = "Parse, generate and render TipTap documents in Ruby."
  spec.description = "A gem for parsing, generating, and rendering TipTap Documents and Nodes using Ruby."
  spec.homepage = "https://github.com/CompanyCam/tiptap-ruby"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.7.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/CompanyCam/tiptap-ruby"
  spec.metadata["changelog_uri"] = "https://github.com/CompanyCam/tiptap-ruby/blob/master/CHANGELOG.md"

  spec.files = Dir["*.{md,txt}", "{lib}/**/*"]
  spec.require_paths = ["lib"]

  spec.add_dependency "actionview", ">= 6.0"
  spec.add_dependency "activesupport", ">= 6.0"
end
