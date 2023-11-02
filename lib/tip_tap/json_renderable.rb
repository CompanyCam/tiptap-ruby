# frozen_string_literal: true

require "tip_tap/registry"

module TipTap
  module JsonRenderable
    def include_empty_content_in_json?
      true
    end

    # Generate a JSON object that is useable by the editor
    def to_h
      json = {type: type_name}
      json = json.merge(content: content.map(&:to_h)) if should_include_content?
      json = json.merge(attrs: attrs.deep_symbolize_keys) if attrs.present?
      json
    end

    private

    def should_include_content?
      content.present? || (content.empty? && include_empty_content_in_json?)
    end
  end
end
