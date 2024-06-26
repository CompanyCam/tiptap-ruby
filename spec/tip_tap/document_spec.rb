# frozen_string_literal: true

require "tip_tap"

RSpec.describe TipTap::Document do
  let(:json_contents) do
    {
      type: "doc",
      content: [
        {
          type: "paragraph",
          content: [
            {
              type: "text",
              text: "Hello World!",
              marks: [
                {type: "bold"},
                {type: "italic"}
              ]
            }
          ]
        }
      ]
    }
  end

  describe "from_json" do
    context "when there is a JSON object" do
      it "returns a document" do
        expect(TipTap::Document.from_json(json_contents)).to be_a(TipTap::Document)
        expect(TipTap::Document.from_json(json_contents).content.size).to be > 0
      end
    end

    context "when JSON is nil" do
      it "returns an empty document" do
        expect(TipTap::Document.from_json(nil)).to be_a(TipTap::Document)
        expect(TipTap::Document.from_json(nil).content).to be_empty
      end
    end

    context "when JSON includes a non-registered node" do
      it "skips the unregistered node" do
        json = {
          type: "doc",
          content: [
            {
              type: "paragraph",
              content: [
                {
                  type: "text",
                  text: "Hello World!",
                  marks: [
                    {type: "bold"},
                    {type: "italic"}
                  ]
                }
              ]
            },
            {
              type: "fake-node",
              content: [
                {
                  type: "text",
                  text: "Hello World!",
                  marks: [
                    {type: "bold"},
                    {type: "italic"}
                  ]
                }
              ]
            }
          ]
        }

        expect {
          TipTap::Document.from_json(json)
        }.to raise_error(TipTap::Registry::MissingNodeError)
      end
    end
  end

  describe "Enumerable" do
    it "iterates over the content for #each" do
      json = {
        type: "doc",
        content: [
          {
            type: "paragraph",
            content: [
              {
                type: "text",
                text: "Hello World!",
                marks: [
                  {type: "bold"},
                  {type: "italic"}
                ]
              }
            ]
          }
        ]
      }
      document = TipTap::Document.from_json(json)
      expect(document.map(&:class)).to eq([TipTap::Nodes::Paragraph])
    end
  end

  describe "find_node" do
    context "when passing a string" do
      it "returns a node" do
        document = TipTap::Document.from_json(json_contents)
        node = document.find_node(TipTap::Nodes::Paragraph.type_name)

        expect(node).to be_a(TipTap::Nodes::Paragraph)
        expect(node.to_plain_text).to eq("Hello World!")
      end
    end

    context "when passing a class" do
      it "returns a node" do
        document = TipTap::Document.from_json(json_contents)
        node = document.find_node(TipTap::Nodes::Paragraph)

        expect(node).to be_a(TipTap::Nodes::Paragraph)
        expect(node.to_plain_text).to eq("Hello World!")
      end
    end
  end

  describe "to_html" do
    it "returns an HTML string" do
      document = TipTap::Document.from_json(json_contents)
      html = document.to_html
      expect(html).to eq('<div class="tiptap-document"><p><strong><em>Hello World!</em></strong></p></div>')
    end
  end

  describe "to_plain_text" do
    it "returns a plain text string" do
      document = TipTap::Document.from_json(json_contents)
      text = document.to_plain_text

      expect(text).to be_a(String)
      expect(text).to eq("Hello World!")
    end
  end

  describe "to_h" do
    it "returns a Hash representation of the object" do
      document = TipTap::Document.from_json(json_contents)
      json = document.to_h

      expect(json).to eq({
        type: "doc",
        content: [
          {type: "paragraph",
           content: [
             {type: "text",
              text: "Hello World!",
              marks: [
                {type: "bold"},
                {type: "italic"}
              ]}
           ]}
        ]
      })
    end
  end

  describe "heading" do
    it "adds a heading node" do
      document = TipTap::Document.new do |document|
        document.heading { |h| h.text("Hello World!") }
      end

      expect(document.content.first).to be_a(TipTap::Nodes::Heading)
    end
  end

  describe "paragraph" do
    it "adds a paragraph node" do
      document = TipTap::Document.new do |document|
        document.paragraph { |p| p.text("Hello World!") }
      end

      expect(document.content.first).to be_a(TipTap::Nodes::Paragraph)
    end
  end

  describe "task_list" do
    it "adds a task list node" do
      document = TipTap::Document.new do |document|
        document.task_list do |tl|
          tl.task_item do |ti|
            ti.paragraph do |para|
              para.text("Hello World!")
            end
          end
        end
      end

      expect(document.content.first).to be_a(TipTap::Nodes::TaskList)
    end
  end

  describe "bullet_list" do
    it "adds a bullet list node" do
      document = TipTap::Document.new do |document|
        document.bullet_list do |bl|
          bl.list_item do |li|
            li.paragraph do |para|
              para.text("Hello World!")
            end
          end
        end
      end

      expect(document.content.first).to be_a(TipTap::Nodes::BulletList)
    end
  end

  describe "blockquote" do
    it "adds a blockquote node" do
      document = TipTap::Document.new do |document|
        document.blockquote do |quote|
          quote.paragraph do |para|
            para.text("Hello World!")
          end
        end
      end

      expect(document.content.first).to be_a(TipTap::Nodes::Blockquote)
    end
  end

  describe "codeblock" do
    it "adds a codeblock node" do
      document = TipTap::Document.new do |document|
        document.codeblock do |codeblock|
          codeblock.code("Hello World!")
        end
      end

      expect(document.content.first).to be_a(TipTap::Nodes::Codeblock)
    end
  end

  describe "blank?" do
    context "when the document is NOT blank" do
      it "returns false" do
        document = TipTap::Document.new do |document|
          document.paragraph { |p| p.text("Hello World!") }
        end
        expect(document.blank?).to eq(false)
      end
    end

    context "when the document is blank" do
      it "returns true" do
        document = TipTap::Document.new.tap(&:paragraph)
        expect(document.blank?).to eq(true)
      end
    end
  end
end
