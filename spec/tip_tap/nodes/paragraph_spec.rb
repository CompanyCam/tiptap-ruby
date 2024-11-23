# frozen_string_literal: true

require "tip_tap"

RSpec.describe TipTap::Nodes::Paragraph do
  describe "to_html" do
    it "returns a p tag" do
      node = TipTap::Nodes::Paragraph.from_json({content: []})
      html = node.to_html

      expect(html).to be_a(String)
      expect(html).to eq("<p></p>")
    end

    context "when the textAlign attribute is present" do
      it "returns a p tag with the specified text alignment style" do
        node = TipTap::Nodes::Paragraph.from_json({content: [], attrs: {'textAlign' => 'center'}})
        html = node.to_html

        expect(html).to be_a(String)
        expect(html).to eq('<p style="text-align: center;"></p>')
      end
    end
  end

  describe "to_h" do
    it "returns a JSON object" do
      node = TipTap::Nodes::Paragraph.new
      json = node.to_h

      expect(json).to eq({type: "paragraph", content: []})
    end
  end

  describe "text" do
    it "adds a text node to the node" do
      paragraph = TipTap::Nodes::Paragraph.new
      paragraph.text("Hello World!")

      expect(paragraph.content.first).to be_a(TipTap::Nodes::Text)
    end
  end
end
