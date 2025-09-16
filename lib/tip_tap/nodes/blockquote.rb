# frozen_string_literal: true

require "tip_tap/node"

module TipTap
  module Nodes
    class Blockquote < Node
      self.type_name = "blockquote"
      self.html_tag = :blockquote
      self.html_class_name = "blockquote"

      def paragraph(&block)
        raise ArgumentError, "Block required" if block.nil?

        add_content(Paragraph.new(&block))
      end

      def to_markdown(context = Markdown::Context.root)
        inner = content.map { |node| node.to_markdown(context) }.reject(&:blank?).join("\n\n")
        lines = inner.split("\n", -1)
        quoted = lines.map do |line|
          line.strip.empty? ? ">" : "> #{line}"
        end
        quoted.join("\n")
      end
    end
  end
end
