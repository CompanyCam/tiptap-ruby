# frozen_string_literal: true

require "tip_tap/node"

module TipTap
  module Nodes
    class Text < Node
      attr_reader :text, :marks

      self.type_name = "text"

      def initialize(content, **attributes)
        @text = content
        @marks = Array(attributes[:marks]).map(&:deep_stringify_keys)
        yield self if block_given?
      end

      def self.from_json(json)
        json.deep_stringify_keys!

        new(json["text"], marks: Array(json["marks"]))
      end

      def to_h
        data = {type: type_name, text: text}
        data[:marks] = marks.map(&:deep_symbolize_keys) unless marks.empty?
        data
      end

      def to_html
        value = text
        value = content_tag(:sup, value) if superscript?
        value = content_tag(:sub, value) if subscript?
        value = highlight_tag(value) if highlight?
        value = content_tag(:code, value) if code?
        value = content_tag(:u, value) if underline?
        value = content_tag(:em, value) if italic?
        value = content_tag(:strong, value) if bold?
        value = content_tag(:s, value) if strike?
        value = content_tag(:a, value, href: link_href, target: link_target) if link?
        value = content_tag(:span, value, style: inline_style_content(text_styles)) if text_style?
        value
      end

      def to_plain_text(separator: " ")
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

      def strike?
        has_mark_with_type?("strike")
      end

      def code?
        has_mark_with_type?("code")
      end

      def superscript?
        has_mark_with_type?("superscript")
      end

      def subscript?
        has_mark_with_type?("subscript")
      end

      def highlight?
        has_mark_with_type?("highlight")
      end

      def text_style?
        has_mark_with_type?("textStyle")
      end

      private

      def has_mark_with_type?(type)
        marks.any? { |mark| mark["type"] == type }
      end

      def link_href
        marks.find { |mark| mark["type"] == "link" }&.dig("attrs", "href")
      end

      def link_target
        marks.find { |mark| mark["type"] == "link" }&.dig("attrs", "target")
      end

      def text_styles
        marks.find { |mark| mark["type"] == "textStyle" }&.dig("attrs")
      end

      def highlight_color
        marks.find { |mark| mark["type"] == "highlight" }&.dig("attrs", "color")
      end

      def inline_style_content(styles)
        return nil if styles.empty?
        styles.reduce("") { |acc, val| acc + "#{val[0]}:#{val[1]};" }
      end

      def highlight_tag(value)
        data = {}
        styles = {}
        if highlight_color
          data[:color] = highlight_color
          styles["background-color"] = highlight_color
          styles[:color] = "inherit"
        end
        content_tag(:mark, text, data: data, style: inline_style_content(styles))
      end
    end
  end
end
