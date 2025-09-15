# frozen_string_literal: true

require "tip_tap/node"

module TipTap
  module Nodes
    class BulletList < Node
      self.type_name = "bulletList"
      self.html_tag = :ul
      self.html_class_name = "bullet-list"
      self.markdown_include_newline_after = true

      def list_item(&block)
        raise ArgumentError, "Block required" if block.nil?

        add_content(ListItem.new(&block))
      end
    end
  end
end
