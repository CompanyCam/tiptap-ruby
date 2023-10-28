# frozen_string_literal: true

require "tip_tap"

RSpec.describe TipTap::Nodes::Blockquote do
  let(:json_content) do
    {
      content: [
        {
          type: "paragraph",
          content: [
            {type: "text", text: "Hello World!"}
          ]
        }
      ]
    }
  end
  describe "to_html" do
    it "returns a blockquote tag" do
      node = TipTap::Nodes::Blockquote.from_json(json_content)
      html = node.to_html

      expect(html).to eq('<blockquote class="blockquote"><p>Hello World!</p></blockquote>')
    end
  end

  describe "to_json" do
    it "returns a JSON object" do
      node = TipTap::Nodes::Blockquote.from_json(json_content)
      json = node.to_json

      expect(json).to eq(json_content.merge(type: "blockquote").deep_symbolize_keys)
    end
  end

  describe "paragraph" do
    it "adds a paragraph to the list item" do
      node = TipTap::Nodes::Blockquote.new
      node.paragraph do |p|
        p.text("Hello World!")
      end

      expect(node.content.first).to be_a(TipTap::Nodes::Paragraph)
    end
  end
end
