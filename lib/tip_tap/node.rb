# frozen_string_literal: true

require "tip_tap/html_renderable"
require "tip_tap/json_renderable"
require "tip_tap/plain_text_renderable"
require "tip_tap/has_content"

# This is the base class for all TipTap nodes.
# It provides some basic functionality that all nodes need such as
# converting to HTML, JSON, and plain text
module TipTap
  class Node
    include HtmlRenderable
    include JsonRenderable
    include PlainTextRenderable
    include HasContent
  end
end
