# frozen_string_literal: true

require "tip_tap"

RSpec.describe TipTap::Nodes::HardBreak do
  describe "to_html" do
    it "returns a br tag" do
      node = TipTap::Nodes::HardBreak.new
      html = node.to_html

      expect(html).to eq("<br>")
    end
  end

  describe "to_markdown" do
    it "returns a markdown hard break" do
      node = TipTap::Nodes::HardBreak.new
      markdown = node.to_markdown

      expect(markdown).to eq("\n")
    end
  end

  describe "to_h" do
    it "returns a JSON object" do
      node = TipTap::Nodes::HardBreak.new
      expect(node.to_h).to eq({type: "hardBreak"})
    end
  end
end
