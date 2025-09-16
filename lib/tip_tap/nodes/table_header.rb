# frozen_string_literal: true

require "tip_tap/nodes/table_cell"

module TipTap
  module Nodes
    class TableHeader < TableCell
      self.type_name = "tableHeader"
      self.html_tag = :th

      def paragraph(&block)
        raise ArgumentError, "Block required" if block.nil?

        add_content(Paragraph.new(&block))
      end
    end
  end
end
