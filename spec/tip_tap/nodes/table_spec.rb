# frozen_string_literal: true

RSpec.describe TipTap::Nodes::Table do
  let(:table) { described_class.new }

  it "has the correct type_name" do
    expect(described_class.type_name).to eq("table")
  end

  it "has the correct html_tag" do
    expect(described_class.html_tag).to eq(:table)
  end

  describe "#to_markdown" do
    it "returns a markdown representation of the table" do
      table.table_row do |row|
        row.table_cell { |cell| cell.paragraph { |p| p.text "Test" } }
      end
      expect(table.to_markdown).to eq("| Test |\n\n")
    end
  end

  describe "#table_row" do
    it "adds a TableRow to the content" do
      table.table_row do |row|
        row.table_cell { |cell| cell.paragraph { |p| p.text "Test" } }
      end

      expect(table.content.first).to be_a(TipTap::Nodes::TableRow)
    end

    it "raises an ArgumentError when no block is given" do
      expect { table.table_row }.to raise_error(ArgumentError, "Block required")
    end
  end

  describe "#to_h" do
    it "returns a hash representation of the table" do
      table.table_row do |row|
        row.table_cell { |cell| cell.paragraph { |p| p.text "Test" } }
      end

      expect(table.to_h).to eq({
        type: "table",
        content: [
          {
            type: "tableRow",
            content: [
              {
                type: "tableCell",
                content: [
                  {
                    type: "paragraph",
                    content: [{type: "text", text: "Test"}]
                  }
                ]
              }
            ]
          }
        ]
      })
    end
  end
end
