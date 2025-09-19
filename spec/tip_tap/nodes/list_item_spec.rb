# frozen_string_literal: true

require "tip_tap"

RSpec.describe TipTap::Nodes::ListItem do
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
    it "returns an li tag" do
      node = TipTap::Nodes::ListItem.from_json(json_content)
      html = node.to_html

      expect(html).to be_a(String)
      expect(html).to eq('<li class="list-item"><p>Hello World!</p></li>')
    end
  end

  describe "to_h" do
    it "returns a JSON object" do
      node = TipTap::Nodes::ListItem.from_json(json_content)
      json = node.to_h

      expect(json).to eq(json_content.merge(type: "listItem").deep_symbolize_keys)
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

  describe "nested lists" do
    it "adds a bullet list" do
      node = TipTap::Nodes::ListItem.new
      node.bullet_list do |list|
        list.list_item { |item| item.paragraph { |p| p.text("Child") } }
      end

      expect(node.content.last).to be_a(TipTap::Nodes::BulletList)
    end

    it "adds an ordered list" do
      node = TipTap::Nodes::ListItem.new
      node.ordered_list do |list|
        list.list_item { |item| item.paragraph { |p| p.text("Child") } }
      end

      expect(node.content.last).to be_a(TipTap::Nodes::OrderedList)
    end

    it "adds a task list" do
      node = TipTap::Nodes::ListItem.new
      node.task_list do |list|
        list.task_item { |item| item.paragraph { |p| p.text("Child") } }
      end

      expect(node.content.last).to be_a(TipTap::Nodes::TaskList)
    end
  end
end
