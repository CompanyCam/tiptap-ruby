# frozen_string_literal: true

require "tip_tap/node"

module TipTap
  module Nodes
    class Paragraph < Node
      self.type_name = "paragraph"
      self.html_tag = :p
      self.markdown_include_newline_after = :parent_requires_newline?

      def text(text, marks: [])
        add_content(Text.new(text, marks: marks))
      end

      # Override the default to_plain_text method to account for the nested Text nodes
      # we don't want to use the separator when joining the text nodes since it could
      # be a newline or some other character that we don't want to include in the plain text
      def to_plain_text(separator: " ")
        content.map { |node| node.to_plain_text(separator: separator) }.join("")
      end

      def parent_requires_newline?
        [ListItem, TaskItem, Blockquote].exclude?(parent.class)
      end
    end
  end
end
