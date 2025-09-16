# frozen_string_literal: true

RSpec.describe TipTap::Nodes::TableCell do
  let(:cell) { described_class.new }

  it "has the correct type_name" do
    expect(described_class.type_name).to eq("tableCell")
  end

  it "has the correct html_tag" do
    expect(described_class.html_tag).to eq(:td)
  end

  describe "#to_markdown" do
    let(:json_content) do
      {
        content: [
          {
            type: "doc", content: [
              {
                type: "tableRow",
                content: [
                  {
                    type: "tableCell",
                    content: [
                      {
                        type: "paragraph",
                        content: [
                          {
                            type: "text", text: "Cell 1"
                          }
                        ]
                      }
                    ]
                  },
                  {
                    type: "tableCell",
                    content: [
                      {
                        type: "paragraph",
                        content: [
                          {
                            type: "text", text: "Cell 2"
                          }
                        ]
                      }
                    ]
                  }
                ]
              }
            ]
          }
        ]
      }
    end

    it "returns a markdown representation of the cell" do
      doc = TipTap::Document.from_json(json_content)
      expect(doc.to_markdown).to eq("| Cell 1 | Cell 2 |\n")
    end
  end

  describe "#paragraph" do
    it "adds a Paragraph to the content" do
      cell.paragraph { |p| p.text "Test" }
      expect(cell.content.first).to be_a(TipTap::Nodes::Paragraph)
    end

    it "raises an ArgumentError when no block is given" do
      expect { cell.paragraph }.to raise_error(ArgumentError, "Block required")
    end
  end

  describe "#to_h" do
    it "returns a hash representation of the cell" do
      cell.paragraph { |p| p.text "Test" }
      expect(cell.to_h).to eq({
        type: "tableCell",
        content: [
          {
            type: "paragraph",
            content: [{type: "text", text: "Test"}]
          }
        ]
      })
    end
  end
end
