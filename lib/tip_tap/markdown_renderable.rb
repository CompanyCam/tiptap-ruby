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

      def markdown_tag
        @markdown_tag || ""
      end

      def markdown_tag_end
        @markdown_tag_end || ""
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

    def to_markdown
      markdown_tag + content.map(&:to_markdown).join("\n") + markdown_tag_end
    end
  end
end
