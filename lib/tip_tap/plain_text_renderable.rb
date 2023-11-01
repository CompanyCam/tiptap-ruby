# frozen_string_literal: true

module TipTap
  module PlainTextRenderable
    # Useful for searching
    def to_plain_text(separator: " ")
      content.map { |node| node.to_plain_text(separator: separator) }.join(separator)
    end
  end
end
