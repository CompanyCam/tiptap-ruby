# frozen_string_literal: true

require "tip_tap/node"

module TipTap
  module Nodes
    class TableHeader < Node
      self.type_name = "tableHeader"
      self.html_tag = :th
      self.markdown_tag = proc do
        # If the header is the first in the row, add the pipe and space, otherwise just add the space
        parent.content.index(self).zero? ? "| " : " "
      end
      self.markdown_tag_end = " |"
      self.markdown_include_newline_after = false

      def paragraph(&block)
        raise ArgumentError, "Block required" if block.nil?

        add_content(Paragraph.new(&block))
      end
    end
  end
end
