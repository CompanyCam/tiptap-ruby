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

  describe "as_json" do
    it "returns a JSON object" do
      node = TipTap::Nodes::HardBreak.new
      expect(node.as_json).to eq({type: "hardBreak"})
    end
  end
end
