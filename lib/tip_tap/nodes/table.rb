# frozen_string_literal: true

require "tip_tap/node"

module TipTap
  module Nodes
    class Table < Node
      self.type_name = "table"
      self.html_tag = :table
      self.html_class_name = "table"

      def table_row(&block)
        raise ArgumentError, "Block required" if block.nil?

        add_content(TableRow.new(&block))
      end
    end
  end
end
