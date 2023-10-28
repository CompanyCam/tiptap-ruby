# frozen_string_literal: true

require "tip_tap"

RSpec.describe TipTap::Nodes::TaskItem do
  describe "to_html" do
    it "returns an li tag" do
      node = TipTap::Nodes::TaskItem.from_json({content: [], attrs: {checked: true}})
      html = node.to_html

      expect(html).to be_a(String)
      expect(html).to eq('<li class="task-item checked"></li>')
    end
  end

  describe "checked?" do
    it "returns if the item is checked" do
      node = TipTap::Nodes::TaskItem.from_json({content: [], attrs: {checked: true}})

      expect(node.checked?).to eq(true)
    end
  end

  describe "paragraph" do
    it "adds a paragraph to the node" do
      node = TipTap::Nodes::TaskItem.new
      node.paragraph do |p|
        p.text("Hello World!")
      end

      expect(node.content.first).to be_a(TipTap::Nodes::Paragraph)
    end
  end

  describe "to_json" do
    it "returns a JSON object" do
      node = TipTap::Nodes::TaskItem.new(checked: true)
      json = node.to_json

      expect(json).to eq({type: "taskItem", attrs: {checked: true}, content: []})
    end
  end
end
