# frozen_string_literal: true

require "action_view"

module TipTap
  module HtmlRenderable
    include ActionView::Helpers::TextHelper
    include ActionView::Helpers::AssetTagHelper

    # ActionView::Helpers::TagHelper requires output_buffer accessor
    # This is included by ActionView::Helpers::TextHelper
    attr_accessor :output_buffer

    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def html_tag=(name_or_proc)
        @html_tag = name_or_proc
      end

      def html_tag
        @html_tag
      end

      def html_class_name=(name_or_proc)
        @html_class_name = name_or_proc
      end

      def html_class_name
        @html_class_name
      end
    end

    def html_tag
      tag = self.class.html_tag
      case tag
      when Proc
        instance_eval(&tag)
      else
        tag
      end
    end

    def html_class_name
      classes = self.class.html_class_name
      case classes
      when Proc
        instance_eval(&classes)
      else
        classes
      end
    end

    def to_html
      content_tag(html_tag, safe_join(content.map(&:to_html)), html_attributes)
    end

    def html_attributes
      {style: inline_styles, class: html_class_name}.reject { |key, value| value.blank?}
    end

    def inline_styles
      styles = []
      styles << "text-align: #{attrs['textAlign']};" if attrs["textAlign"]
      styles.join(" ")
    end
  end
end
