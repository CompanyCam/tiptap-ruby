# frozen_string_literal: true

require "tip_tap/node"

module TipTap
  module Nodes
    class HardBreak < Node
      self.type_name = "hardBreak"

      def include_empty_content_in_json?
        false
      end

      def to_html
        tag.br
      end

      def to_markdown(context = Markdown::Context.root)
        "  \n"
      end
    end
  end
end
