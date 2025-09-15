# frozen_string_literal: true

require "tip_tap/node"

module TipTap
  module Nodes
    class Image < Node
      self.type_name = "image"
      self.markdown_include_newline_after = true

      def include_empty_content_in_json?
        false
      end

      def to_html
        image_tag(src, alt: alt)
      end

      def to_markdown
        "![#{markdown_alt_text}](#{src})\n"
      end

      def alt
        attrs["alt"]
      end

      def src
        attrs["src"]
      end

      def markdown_alt_text
        alt || "Image"
      end
    end
  end
end
