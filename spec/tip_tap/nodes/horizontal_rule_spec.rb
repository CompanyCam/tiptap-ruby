# frozen_string_literal: true

require "tip_tap"

RSpec.describe TipTap::Nodes::HorizontalRule do
  describe "to_html" do
    it "returns a hr tag" do
      node = TipTap::Nodes::HorizontalRule.new
      html = node.to_html

      expect(html).to eq("<hr>")
    end
  end

  describe "to_h" do
    it "returns a JSON object" do
      node = TipTap::Nodes::HorizontalRule.new
      expect(node.to_h).to eq({type: "horizontalRule"})
    end
  end
end
