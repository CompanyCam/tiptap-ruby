# frozen_string_literal: true

require "tip_tap"

RSpec.describe TipTap::Nodes::Codeblock do
  describe "to_html" do
    it "returns a pre tag" do
      node = TipTap::Nodes::Codeblock.from_json({content: []})
      html = node.to_html

      expect(html).to eq("<pre></pre>")
    end
  end

  describe "to_markdown" do
    it "returns a markdown codeblock" do
      node = TipTap::Nodes::Codeblock.from_json({content: [{type: "text", text: "Hello World!", marks: [{type: "code"}]}], attrs: {language: "ruby"}})
      markdown = node.to_markdown

      expect(markdown).to eq("```ruby\nHello World!```")
    end
  end

  describe "to_h" do
    it "returns a JSON object" do
      node = TipTap::Nodes::Codeblock.new
      json = node.to_h

      expect(json).to eq({type: "codeBlock", content: []})
    end
  end

  describe "code" do
    it "adds a text node to the node with a code mark" do
      paragraph = TipTap::Nodes::Codeblock.new
      paragraph.code("Hello World!")

      text = paragraph.content.first
      expect(text).to be_a(TipTap::Nodes::Text)
      expect(text.code?).to eq(true)
    end
  end
end
