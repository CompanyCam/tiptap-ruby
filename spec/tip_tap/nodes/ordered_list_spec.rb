# frozen_string_literal: true

require "tip_tap"

RSpec.describe TipTap::Nodes::OrderedList do
  let(:json_contents) do
    {
      attrs: {
        start: 1
      },
      content: [
        {
          type: "listItem",
          content: [
            {
              type: "paragraph",
              content: [
                {
                  type: "text",
                  text: "Hello World!",
                  marks: [
                    {type: "bold"}
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
    it "returns a ol tag" do
      node = TipTap::Nodes::OrderedList.from_json(json_contents)
      html = node.to_html

      expect(html).to be_a(String)
      expect(html).to eq('<ol class="ordered-list"><li class="list-item"><p><strong>Hello World!</strong></p></li></ol>')
    end
  end

  describe "to_markdown" do
    it "returns a markdown ordered list" do
      node = TipTap::Nodes::OrderedList.from_json(json_contents)
      markdown = node.to_markdown

      expect(markdown).to eq("1. **Hello World!**")
    end
  end

  describe "to_h" do
    it "returns a JSON object" do
      node = TipTap::Nodes::OrderedList.from_json(json_contents)
      json = node.to_h

      expect(json).to eq(json_contents.merge(type: "orderedList").deep_symbolize_keys)
    end
  end

  describe "list_item" do
    it "adds a list item to the list" do
      node = TipTap::Nodes::OrderedList.new
      node.list_item do |li|
        li.paragraph do |p|
          p.text("Hello World!")
        end
      end

      expect(node.content.first).to be_a(TipTap::Nodes::ListItem)
    end
  end

  describe "start" do
    it "returns the start attribute" do
      node = TipTap::Nodes::OrderedList.from_json(json_contents)

      expect(node.start).to eq(1)
    end
  end
end
