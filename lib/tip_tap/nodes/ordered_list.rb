# frozen_string_literal: true

require "tip_tap/node"

module TipTap
  module Nodes
    class OrderedList < Node
      self.type_name = "orderedList"
      self.html_tag = :ol
      self.html_class_name = "ordered-list"

      def list_item(&block)
        raise ArgumentError, "Block required" if block.nil?

        add_content(ListItem.new(&block))
      end

      def start
        attrs["start"]
      end
    end
  end
end
