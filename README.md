# Tiptap

A gem for parsing, generating, and rendering TipTap Documents and Nodes using Ruby.

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add tiptap-ruby

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install tiptap-ruby

## Usage

### Parsing a TipTap Document

You can parse a TipTap Document so that you can interact with it to do things such as add content (Nodes) or render it as HTML, JSON, or plain text:

```ruby
document = TipTap::Document.from_json(tiptap_json)
```

### Generate a New Document

```ruby
document = TipTap::Document.new
```

You can also pass a block and the new Document will be yielded to the block.

```ruby
TipTap::Document.new do |document|
  # Do something with document
end
```

### Add Content to the Document

Now that you have a Document you can add content to it.

```ruby
document.heading(level: 1) do |heading|
  heading.text("My Import Document", marks: [{type: "italic"}])
end
```

Until the gem implements all of the node types and the documentation is complete, refer to the `Document` class to see the nodes that can be appended.

### Generate Output

Once you have a Document with some content you can render it to HTML, JSON, and plain text.

#### JSON

```ruby
document.to_json # => { type: 'doc', content: […nodes]}
```

### HTML

```ruby
document.to_html # => <div class="tiptap-document"><h1><em>My Important Document</em></h1></div>
```

### Plain Text

Rendering to plain text is useful if you want to search the contents of your TipTap content.

```ruby
document.to_plain_text # => My Important Document
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bundle exec rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle install`.

To release a new version, update the version number in `version.rb`, and then run `bin/release` or `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/chadwilken/tiptap-ruby.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
