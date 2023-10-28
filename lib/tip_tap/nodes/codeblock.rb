# frozen_string_literal: true

require "tip_tap/node"

module TipTap
  module Nodes
    class Codeblock < Node
      self.type_name = "codeBlock"
      self.html_tag = :pre

      def code(text)
        add_content(Text.new(text, marks: [{type: "code"}]))
      end
    end
  end
end
