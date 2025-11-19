# frozen_string_literal: true

require "tip_tap/node"

module TipTap
  module Nodes
    class Heading < Node
      self.type_name = "heading"
      self.html_tag = proc { "h#{level}" }

      def initialize(content = [], **attributes)
        super(content, **attributes)
        uuid = SecureRandom.uuid
        @attrs["id"] = uuid
        @attrs["data-toc-id"] = uuid
      end

      def text(text, marks: [])
        add_content(Text.new(text, marks: marks))
      end

      def level
        attrs["level"]
      end
    end
  end
end
