# frozen_string_literal: true

require "tip_tap"

RSpec.describe TipTap::Nodes::BulletList do
  let(:json_contents) do
    {
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
    it "returns a ul tag" do
      node = TipTap::Nodes::BulletList.from_json(json_contents)
      html = node.to_html

      expect(html).to be_a(String)
      expect(html).to eq('<ul class="bullet-list"><li class="list-item"><p><strong>Hello World!</strong></p></li></ul>')
    end
  end

  describe "to_markdown" do
    it "returns a markdown bullet list" do
      node = TipTap::Nodes::BulletList.from_json(json_contents)
      markdown = node.to_markdown

      expect(markdown).to eq("- **Hello World!**")
    end
  end

  describe "to_h" do
    it "returns a JSON object" do
      node = TipTap::Nodes::BulletList.from_json(json_contents)
      json = node.to_h

      expect(json).to eq(json_contents.merge(type: "bulletList").deep_symbolize_keys)
    end
  end

  describe "list_item" do
    it "adds a list item to the list" do
      node = TipTap::Nodes::BulletList.new
      node.list_item do |li|
        li.paragraph do |p|
          p.text("Hello World!")
        end
      end

      expect(node.content.first).to be_a(TipTap::Nodes::ListItem)
    end
  end
end
