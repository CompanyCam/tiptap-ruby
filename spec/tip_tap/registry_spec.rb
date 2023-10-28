# frozen_string_literal: true

require "tip_tap"

RSpec.describe TipTap::Registry do
  describe ".register" do
    it "registers a node" do
      TipTap::Registry.register("myNode", String)
      expect(TipTap::Registry.registry["myNode"]).to eq(String)
    end
  end

  describe ".node_for" do
    it "returns the node for the given name" do
      TipTap::Registry.register("myNode", String)
      expect(TipTap::Registry.node_for("myNode")).to eq(String)
    end

    it "raises an error if the node is not registered" do
      expect { TipTap::Registry.node_for("someTestNode") }.to raise_error(TipTap::Registry::MissingNodeError)
    end
  end
end
