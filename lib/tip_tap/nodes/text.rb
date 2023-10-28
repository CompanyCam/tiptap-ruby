# frozen_string_literal: true

require "tip_tap/json_renderable"
require "tip_tap/html_renderable"

module TipTap
  module Nodes
    class Text
      include JsonRenderable
      include HtmlRenderable

      attr_reader :text, :marks

      self.type_name = "text"

      def initialize(text, marks: [])
        @text = text
        @marks = marks.map(&:deep_stringify_keys)
      end

      def self.from_json(json)
        json.deep_stringify_keys!

        new(json["text"], marks: Array(json["marks"]))
      end

      def to_json
        {type: type_name, text: text, marks: marks.map(&:deep_symbolize_keys)}.compact_blank
      end

      def to_html
        value = text
        value = content_tag(:u, value) if underline?
        value = content_tag(:em, value) if italic?
        value = content_tag(:strong, value) if bold?
        value = content_tag(:a, value, href: link_href, target: link_target) if link?
        value
      end

      def to_plain_text
        text
      end

      def italic?
        has_mark_with_type?("italic")
      end

      def bold?
        has_mark_with_type?("bold")
      end

      def underline?
        has_mark_with_type?("underline")
      end

      def link?
        has_mark_with_type?("link")
      end

      def link_href
        marks.find { |mark| mark["type"] == "link" }&.dig("attrs", "href")
      end

      def link_target
        marks.find { |mark| mark["type"] == "link" }&.dig("attrs", "target")
      end

      private

      def has_mark_with_type?(type)
        marks.any? { |mark| mark["type"] == type }
      end
    end
  end
end
