# frozen_string_literal: true

require "tip_tap/html_renderable"
require "tip_tap/json_renderable"
require "tip_tap/plain_text_renderable"
require "tip_tap/has_content"

# This is the class that all child nodes will be added to.
# This is the root object for TipTap.
module TipTap
  class Document
    include JsonRenderable
    include HtmlRenderable
    include PlainTextRenderable
    include HasContent

    self.type_name = "doc"
    self.html_tag = :div
    self.html_class_name = "tiptap-document"

    def heading(level: 1, &block)
      raise ArgumentError, "Block required" if block.nil?

      add_content(Nodes::Heading.new(level: level, &block))
    end

    def paragraph(&block)
      add_content(Nodes::Paragraph.new(&block))
    end

    def task_list(&block)
      raise ArgumentError, "Block required" if block.nil?

      add_content(Nodes::TaskList.new(&block))
    end

    def bullet_list(&block)
      raise ArgumentError, "Block required" if block.nil?

      add_content(Nodes::BulletList.new(&block))
    end

    def image(src:)
      add_content(Nodes::Image.new(src: src))
    end
  end
end
