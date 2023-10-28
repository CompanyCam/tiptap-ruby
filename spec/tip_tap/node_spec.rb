# frozen_string_literal: true

require "tip_tap"

NodeSubclass = Class.new(TipTap::Node)
NodeSubclass.type_name = "nodeSubclass"
NodeSubclass.html_tag = :div
NodeSubclass.html_class_name = "node-subclass"

RSpec.describe TipTap::Node do
  describe "initialize" do
    it "sets the attrs" do
      node = TipTap::Node.new(checked: true)
      expect(node.attrs).to eq({"checked" => true})
    end

    it "camelcases the keys" do
      node = TipTap::Node.new(image_id: 1)
      expect(node.attrs).to eq({"imageId" => 1})
    end
  end

  describe "type_name=" do
    it "sets the type_name" do
      my_node = Class.new(TipTap::Node)
      my_node.type_name = "my_node"
      my_node_2 = Class.new(TipTap::Node)
      my_node_2.type_name = "my_node_2"
      expect(my_node.type_name).to eq("my_node")
      expect(my_node_2.type_name).to eq("my_node_2")
    end

    it "registers the node" do
      my_node = Class.new(TipTap::Node)
      my_node.type_name = "my_node"
      my_node_2 = Class.new(TipTap::Node)
      my_node_2.type_name = "my_node_2"
      expect(TipTap::Registry.node_for("my_node")).to eq(my_node)
      expect(TipTap::Registry.node_for("my_node_2")).to eq(my_node_2)
    end
  end

  describe "to_html" do
    it "renders the html" do
      expect(NodeSubclass.new.to_html).to eq('<div class="node-subclass"></div>')
    end
  end

  describe "to_json" do
    context "when the node is a Node class" do
      it "returns an only the content" do
        node = TipTap::Node.new
        expect(node.to_json).to eq({type: nil, content: []})
      end
    end

    context "when the node is a subclass of Node" do
      it "returns a JSON representation of the object" do
        klass = Class.new(TipTap::Node)
        klass.type_name = "myTestNode"
        node = klass.new(test: "test")
        expect(node.to_json).to eq({type: "myTestNode", content: [], attrs: {test: "test"}})
      end
    end
  end

  describe "from_json" do
    context "when the node is registered" do
      it "returns a node" do
        node = TipTap::Node.from_json({content: [{type: "text", text: "Hello World!"}]})
        expect(node).to be_a(TipTap::Node)
      end
    end

    context "when the node is not registered" do
      it "raises an error" do
        expect {
          TipTap::Node.from_json({content: [{type: "fake-type", text: "Hello World!"}]})
        }.to raise_error(TipTap::Registry::MissingNodeError)
      end
    end
  end

  describe "to_plain_text" do
    it "returns a plain text string" do
      node = TipTap::Node.from_json({content: [{type: "text", text: "Hello World!"}]})
      text = node.to_plain_text

      expect(text).to be_a(String)
      expect(text).to eq("Hello World!")
    end
  end
end
