# frozen_string_literal: true

RSpec.describe TipTap::Nodes::TableRow do
  let(:row) { described_class.new }

  it "has the correct type_name" do
    expect(described_class.type_name).to eq("tableRow")
  end

  it "has the correct html_tag" do
    expect(described_class.html_tag).to eq(:tr)
  end

  describe "#to_markdown" do
    it "returns a markdown representation of the row" do
      row.table_cell { |cell| cell.paragraph { |p| p.text "Test" } }
      expect(row.to_markdown).to eq("| Test |\n")
    end
  end

  describe "#table_cell" do
    it "adds a TableCell to the content" do
      row.table_cell { |cell| cell.paragraph { |p| p.text "Test" } }
      expect(row.content.first).to be_a(TipTap::Nodes::TableCell)
    end

    it "raises an ArgumentError when no block is given" do
      expect { row.table_cell }.to raise_error(ArgumentError, "Block required")
    end
  end

  describe "#table_header" do
    it "adds a TableHeader to the content" do
      row.table_header { |header| header.paragraph { |p| p.text "Header" } }
      expect(row.content.first).to be_a(TipTap::Nodes::TableHeader)
    end

    it "raises an ArgumentError when no block is given" do
      expect { row.table_header }.to raise_error(ArgumentError, "Block required")
    end
  end
end
