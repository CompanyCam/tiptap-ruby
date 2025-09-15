# frozen_string_literal: true

require "tip_tap/node"

module TipTap
  module Nodes
    class TableRow < Node
      self.type_name = "tableRow"
      self.html_tag = :tr
      self.markdown_include_newline_after = true

      def table_cell(&block)
        raise ArgumentError, "Block required" if block.nil?

        add_content(TableCell.new(&block))
      end

      def table_header(&block)
        raise ArgumentError, "Block required" if block.nil?

        add_content(TableHeader.new(&block))
      end
    end
  end
end
