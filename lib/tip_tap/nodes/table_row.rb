# frozen_string_literal: true

require "tip_tap/node"

module TipTap
  module Nodes
    class TableRow < Node
      self.type_name = "tableRow"
      self.html_tag = :tr

      def table_cell(&block)
        raise ArgumentError, "Block required" if block.nil?

        add_content(TableCell.new(&block))
      end

      def table_header(&block)
        raise ArgumentError, "Block required" if block.nil?

        add_content(TableHeader.new(&block))
      end

      def to_markdown(context = Markdown::Context.root)
        row_data = to_markdown_row(context)
        "| #{row_data[:cells].join(' | ')} |"
      end

      def to_markdown_row(context = Markdown::Context.root)
        {
          cells: content.map { |node| node.to_markdown(context) },
          header: content.all? { |node| node.is_a?(TableHeader) }
        }
      end
    end
  end
end
