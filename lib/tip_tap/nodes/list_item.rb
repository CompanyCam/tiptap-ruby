# frozen_string_literal: true

require "tip_tap/node"

module TipTap
  module Nodes
    class ListItem < Node
      self.type_name = "listItem"
      self.html_tag = :li
      self.html_class_name = "list-item"
      self.markdown_tag = proc do
        parent.is_a?(BulletList) ? "- " : "#{index}. "
      end
      self.markdown_include_newline_after = true

      def paragraph(&block)
        raise ArgumentError, "Block required" if block.nil?

        add_content(Paragraph.new(&block))
      end

      private

      def index
        parent.content.index(self) + parent.start
      end
    end
  end
end
