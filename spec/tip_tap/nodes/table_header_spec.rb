# frozen_string_literal: true

RSpec.describe TipTap::Nodes::TableHeader do
  let(:header) { described_class.new }

  it "has the correct type_name" do
    expect(described_class.type_name).to eq("tableHeader")
  end

  it "has the correct html_tag" do
    expect(described_class.html_tag).to eq(:th)
  end

  describe "#to_markdown" do
    it "returns a markdown representation of the header" do
      header.paragraph { |p| p.text "Header" }
      expect(header.to_markdown).to eq("| Header |")
    end
  end

  describe "#paragraph" do
    it "adds a Paragraph to the content" do
      header.paragraph { |p| p.text "Header" }
      expect(header.content.first).to be_a(TipTap::Nodes::Paragraph)
    end

    it "raises an ArgumentError when no block is given" do
      expect { header.paragraph }.to raise_error(ArgumentError, "Block required")
    end
  end

  describe "#to_h" do
    it "returns a hash representation of the header" do
      header.paragraph { |p| p.text "Header" }
      expect(header.to_h).to eq({
        type: "tableHeader",
        content: [
          {
            type: "paragraph",
            content: [{type: "text", text: "Header"}]
          }
        ]
      })
    end
  end
end
