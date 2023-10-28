# frozen_string_literal: true

require "tip_tap/node"

module TipTap
  module Nodes
    class TaskItem < Node
      self.type_name = "taskItem"
      self.html_tag = :li
      self.html_class_name = proc { class_names("task-item", {checked: checked?}) }

      def paragraph(&block)
        raise ArgumentError, "Block required" if block.nil?

        add_content(Paragraph.new(&block))
      end

      def checked?
        attrs["checked"]
      end
    end
  end
end
