# frozen_string_literal: true

require_relative "tip_tap/version"
require "tip_tap/registry"
require "tip_tap/document"
require "tip_tap/nodes/bullet_list"
require "tip_tap/nodes/hard_break"
require "tip_tap/nodes/heading"
require "tip_tap/nodes/horizontal_rule"
require "tip_tap/nodes/list_item"
require "tip_tap/nodes/ordered_list"
require "tip_tap/nodes/paragraph"
require "tip_tap/nodes/task_item"
require "tip_tap/nodes/task_list"
require "tip_tap/nodes/text"
require "tip_tap/nodes/image"
require "tip_tap/nodes/blockquote"

module TipTap
  class Error < StandardError; end

  def self.node_for(name)
    Registry.node_for(name)
  end
end
