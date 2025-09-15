# frozen_string_literal: true

module TipTap
  module MarkdownRenderable
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def markdown_tag=(name_or_proc)
        @markdown_tag = name_or_proc
      end

      def markdown_tag_end=(name_or_proc)
        @markdown_tag_end = name_or_proc
      end

      def markdown_include_newline_after=(value)
        @markdown_include_newline_after = value
      end

      def markdown_tag
        @markdown_tag || ""
      end

      def markdown_tag_end
        @markdown_tag_end || ""
      end

      def markdown_include_newline_after
        @markdown_include_newline_after || false
      end
    end

    def markdown_tag
      tag = self.class.markdown_tag
      case tag
      when Proc
        instance_eval(&tag)
      else
        tag
      end
    end

    def markdown_tag_end
      tag = self.class.markdown_tag_end
      case tag
      when Proc
        instance_eval(&tag)
      else
        tag
      end
    end

    def markdown_include_newline_after?
      newline = self.class.markdown_include_newline_after
      case newline
      when Proc
        instance_eval(&newline)
      when Symbol
        send(newline)
      else
        newline
      end
    end

    def to_markdown
      markdown_tag + content.map(&:to_markdown).join("") + markdown_tag_end + (markdown_include_newline_after? ? "\n" : "")
    end
  end
end
