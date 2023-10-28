# frozen_string_literal: true

require "tip_tap/registry"

module TipTap
  module JsonRenderable
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def type_name=(type_name)
        @type_name = type_name
        Registry.register(type_name, self)
      end

      def type_name
        @type_name
      end
    end

    def type_name
      self.class.type_name
    end

    def include_empty_content_in_json?
      true
    end

    # Generate a JSON object that is useable by the editor
    def to_json
      json = {type: type_name}
      json = json.merge(content: content.map(&:to_json)) if should_include_content?
      json = json.merge(attrs: attrs.deep_symbolize_keys) if attrs.present?
      json
    end

    private

    def should_include_content?
      content.present? || (content.empty? && include_empty_content_in_json?)
    end
  end
end
