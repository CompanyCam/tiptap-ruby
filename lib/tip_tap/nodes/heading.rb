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

      def to_markdown(context = Markdown::Context.root)
        heading_level = [level.to_i, 1].max
        prefix = "#" * heading_level
        body = content.map { |node| node.to_markdown(context) }.join.strip
        body.empty? ? prefix : "#{prefix} #{body}"
      end
    end
  end
end
