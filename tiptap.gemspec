# frozen_string_literal: true

require_relative "lib/tip_tap/version"

Gem::Specification.new do |spec|
  spec.name = "tiptap-ruby"
  spec.version = TipTap::VERSION
  spec.authors = ["Chad Wilken"]
  spec.email = ["chad.wilken@gmail.com"]

  spec.summary = "Generate and parse TipTap documents in Ruby."
  spec.description = "A library that allows you to generate, parse, and render TipTap documents in Ruby."
  spec.homepage = "https://github.com/chadwilken/tiptap-ruby"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.7.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/chadwilken/tiptap-ruby"
  spec.metadata["changelog_uri"] = "https://github.com/chadwilken/tiptap-ruby/blob/master/CHANGELOG.md"

  spec.files = Dir["*.{md,txt}", "{lib}/**/*"]
  spec.require_paths = ["lib"]

  spec.add_dependency "actionview", "~> 6.0"
  spec.add_dependency "activesupport", "~> 6.0"
end
