# frozen_string_literal: true

require "tip_tap/node"

module TipTap
  module Nodes
    class Blockquote < Node
      self.type_name = "blockquote"
      self.html_tag = :blockquote
      self.html_class_name = "blockquote"
      self.markdown_tag = "> "
      self.markdown_include_newline_after = true

      def paragraph(&block)
        raise ArgumentError, "Block required" if block.nil?

        add_content(Paragraph.new(&block))
      end
    end
  end
end
