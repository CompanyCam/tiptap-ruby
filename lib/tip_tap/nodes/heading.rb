# frozen_string_literal: true

require "tip_tap/node"

module TipTap
  module Nodes
    class Heading < Node
      self.type_name = "heading"
      self.html_tag = proc { "h#{level}" }

      def text(text, marks: [])
        add_content(Text.new(text, marks: marks))
      end

      def level
        attrs["level"]
      end
    end
  end
end
