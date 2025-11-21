# frozen_string_literal: true

module TipTap
  module Markdown
    # Rendering context for markdown serialization. Tracks indentation
    # for nested blocks and whether we are currently inside a fenced
    # code block so nodes can adjust formatting.
    class Context
      attr_reader :indent, :within_code_block

      def initialize(indent: 0, within_code_block: false)
        @indent = indent
        @within_code_block = within_code_block
      end

      def self.root
        new
      end

      def indentation
        " " * indent
      end

      def increase_indent(amount)
        self.class.new(indent: indent + amount, within_code_block: within_code_block)
      end

      def with_code_block
        self.class.new(indent: indent, within_code_block: true)
      end

      def within_code_block?
        within_code_block
      end
    end
  end

  module MarkdownRenderable
    def to_markdown(context = Markdown::Context.root)
      rendered_blocks = content.map { |node| node.to_markdown(context) }.reject(&:blank?)
      rendered_blocks.join("\n\n").gsub(/\n{3,}/, "\n\n").rstrip
    end
  end
end
