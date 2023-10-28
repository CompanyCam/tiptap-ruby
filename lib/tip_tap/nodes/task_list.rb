# frozen_string_literal: true

require "tip_tap/node"

module TipTap
  module Nodes
    class TaskList < Node
      self.type_name = "taskList"
      self.html_tag = :ul
      self.html_class_name = "task-list"

      def task_item(checked: false, &block)
        raise ArgumentError, "Block required" if block.nil?

        add_content(TaskItem.new(checked: checked, &block))
      end
    end
  end
end
