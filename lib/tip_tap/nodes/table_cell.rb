# frozen_string_literal: true

require "tip_tap/node"

module TipTap
  module Nodes
    class TableCell < Node
      self.type_name = "tableCell"
      self.html_tag = :td

      def paragraph(&block)
        raise ArgumentError, "Block required" if block.nil?

        add_content(Paragraph.new(&block))
      end

      def to_markdown(context = Markdown::Context.root)
        render_cell_content(context)
      end

      private

      def render_cell_content(context)
        values = content.map { |node| node.to_markdown(context) }.reject(&:blank?)
        joined = values.join("<br>")
        sanitized = joined.gsub("\n\n", "<br><br>").gsub("\n", "<br>")
        sanitized.gsub("|", "\\|")
      end
    end
  end
end
