# frozen_string_literal: true

require "tip_tap/node"

module TipTap
  module Nodes
    class HorizontalRule < Node
      self.type_name = "horizontalRule"
      self.markdown_tag = "---"
      self.markdown_include_newline_after = true

      def include_empty_content_in_json?
        false
      end

      def to_html
        tag.hr
      end
    end
  end
end
