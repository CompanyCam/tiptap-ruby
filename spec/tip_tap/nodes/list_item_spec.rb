# frozen_string_literal: true

require "tip_tap"

RSpec.describe TipTap::Nodes::ListItem do
  let(:json_content) do
    {
      type: "doc",
      content: [
        {
          type: "bulletList",
          content: [
            {
              type: "listItem",
              content: [
                {
                  type: "paragraph",
                  content: [
                    {type: "text", text: "Hello World!"}
                  ]
                }
              ]
            }
          ]
        }
      ]
    }
  end

  let(:ordered_json_content) do
    {
      type: "doc",
      content: [
        {
          type: "orderedList",
          content: [
            {
              type: "listItem",
              content: [
                {
                  type: "paragraph",
                  content: [
                    {type: "text", text: "Hello World!"}
                  ]
                }
              ]
            }
          ]
        }
      ]
    }
  end

  describe "to_html" do
    it "returns an li tag" do
      node = TipTap::Document.from_json(json_content)
      html = node.to_html

      expect(html).to be_a(String)
      expect(html).to include('<li class="list-item"><p>Hello World!</p></li>')
    end
  end

  describe "to_markdown" do
    it "returns a markdown list item" do
      node = TipTap::Document.from_json(json_content)
      markdown = node.to_markdown

      expect(markdown).to eq("- Hello World!\n\n")
    end

    context "when the list is ordered" do
      it "returns a markdown numbered list item" do
        node = TipTap::Document.from_json(ordered_json_content)
        markdown = node.to_markdown

        expect(markdown).to eq("1. Hello World!\n\n")
      end
    end
  end

  describe "to_h" do
    it "returns a JSON object" do
      node = TipTap::Document.from_json(json_content)
      json = node.to_h

      expect(json).to eq(json_content.deep_symbolize_keys)
    end
  end

  describe "paragraph" do
    it "adds a paragraph to the list item" do
      node = TipTap::Nodes::ListItem.new
      node.paragraph do |p|
        p.text("Hello World!")
      end

      expect(node.content.first).to be_a(TipTap::Nodes::Paragraph)
    end
  end
end
