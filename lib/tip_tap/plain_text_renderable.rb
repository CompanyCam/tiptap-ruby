# frozen_string_literal: true

module TipTap
  module PlainTextRenderable
    # Useful for searching
    def to_plain_text(separator: " ")
      content.map(&:to_plain_text).join(separator)
    end
  end
end
