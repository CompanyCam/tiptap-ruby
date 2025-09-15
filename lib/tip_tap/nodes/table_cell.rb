# frozen_string_literal: true

require "tip_tap/node"

module TipTap
  module Nodes
    class TableCell < Node
      self.type_name = "tableCell"
      self.html_tag = :td
      self.markdown_tag = "| "
      self.markdown_tag_end = " |"
      self.markdown_include_newline_after = false

      def paragraph(&block)
        raise ArgumentError, "Block required" if block.nil?

        add_content(Paragraph.new(&block))
      end
    end
  end
end
