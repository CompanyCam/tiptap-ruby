# frozen_string_literal: true

require "tip_tap"

RSpec.describe TipTap::Nodes::Heading do
  describe "to_html" do
    it "returns a tag corresponding to the level attribute" do
      node = TipTap::Nodes::Heading.from_json({content: [], attrs: {level: 2}})
      html = node.to_html

      expect(html).to be_a(String)
      expect(html).to eq("<h2></h2>")
    end

    context "when the textAlign attribute is present" do
      it "returns a tag with the specified text alignment style" do
        node = TipTap::Nodes::Heading.from_json({content: [], attrs: {'textAlign' => 'center', level: 2}})
        html = node.to_html

        expect(html).to be_a(String)
        expect(html).to eq('<h2 style="text-align: center;"></h2>')
      end
    end
  end

  describe "level" do
    it "returns a the level attribute" do
      node = TipTap::Nodes::Heading.from_json({content: [], attrs: {level: 2}})
      expect(node.level).to eq(2)
    end
  end

  describe "text" do
    it "adds a text node to the node" do
      heading = TipTap::Nodes::Heading.new(level: 1)
      heading.text("Hello World!")

      expect(heading.content.first).to be_a(TipTap::Nodes::Text)
    end
  end

  describe "to_h" do
    it "returns a JSON object" do
      node = TipTap::Nodes::Heading.new(level: 1)
      json = node.to_h

      expect(json).to eq({type: "heading", attrs: {level: 1}, content: []})
    end
  end
end
