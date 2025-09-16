# frozen_string_literal: true

require "tip_tap/node"

module TipTap
  module Nodes
    class TableRow < Node
      self.type_name = "tableRow"
      self.html_tag = :tr
      self.markdown_tag_end = proc do
        # If the row is all TableHeaders we want to add the header markdown tag ( | --- | ) below the row.
        if content.all?(TableHeader)
          "\n" + content.size.times.map do |index|
            index.zero? ? "| --- |" : " --- |"
          end.join("")
        else
          ""
        end
      end

      self.markdown_include_newline_after = :parent_requires_newline?

      def table_cell(&block)
        raise ArgumentError, "Block required" if block.nil?

        add_content(TableCell.new(&block))
      end

      def table_header(&block)
        raise ArgumentError, "Block required" if block.nil?

        add_content(TableHeader.new(&block))
      end

      def parent_requires_newline?
        !content.all?(TableHeader)
      end
    end
  end
end
