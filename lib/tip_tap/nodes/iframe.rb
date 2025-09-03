# frozen_string_literal: true

require "tip_tap/node"

module TipTap
  module Nodes
    class Iframe < Node
      self.type_name = 'iframe'

      def include_empty_content_in_json?
        false
      end

      def to_html
        tag.div(class: 'iframe', style: style) do
          content_tag(:iframe, nil,
                      src: src,
                      width: width || 560,
                      height: height || 315,
                      frameborder: 0,
                      referrerpolicy: 'strict-origin-when-cross-origin',
                      title: title
          )
        end
      end

      def src
        attrs['src']
      end

      def width
        w = attrs['width']&.to_i
        w == 0 ? nil : w
      end

      def height
        h = attrs['height']&.to_i
        h == 0 ? nil : h
      end

      def title
        attrs['title']
      end

      def style
        styles = {}

        if width.present? && height.present?
          gcd = width.gcd(height)
          styles['--ratio:'] = "#{width / gcd}\/#{height / gcd}"
        end

        styles
      end
    end
  end
end
