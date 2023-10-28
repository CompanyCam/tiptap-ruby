# frozen_string_literal: true

require "tip_tap/node"

module TipTap
  module Nodes
    class ListItem < Node
      self.type_name = "listItem"
      self.html_tag = :li
      self.html_class_name = "list-item"

      def paragraph(&block)
        raise ArgumentError, "Block required" if block.nil?

        add_content(Paragraph.new(&block))
      end
    end
  end
end
