# frozen_string_literal: true

require "tip_tap/node"

module TipTap
  module Nodes
    class Paragraph < Node
      self.type_name = "paragraph"
      self.html_tag = :p

      def text(text, marks: [])
        add_content(Text.new(text, marks: marks))
      end
    end
  end
end
