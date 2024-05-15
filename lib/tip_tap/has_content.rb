# frozen_string_literal: true

require "active_support/core_ext/hash"

module TipTap
  module HasContent
    include Enumerable

    attr_reader :attrs, :content

    def self.included(base)
      base.extend(ClassMethods)
    end

    # Create a new document or node, optionally passing in attributes (attrs) and nodes
    # @param nodes [Array] An array of nodes to add to this node
    # @param attributes [Hash] A hash of attributes to add to this node e.g. { 'level' => 1 }
    def initialize(content = [], **attributes)
      # This will convert the attrs key to camelcase for example :image_id is converted into 'imageId'
      @attrs = Hash(attributes).deep_transform_keys { |key| key.to_s.camelcase(:lower) }
      @content = content
      yield self if block_given?
    end

    def each
      content.each { |child| yield child }
    end

    def find_node(type_class_or_name)
      node_type = type_class_or_name.is_a?(String) ? TipTap.node_for(type_class_or_name) : type_class_or_name
      find { |child| child.is_a?(node_type) }
    end

    def add_content(node)
      @content << node
    end
    alias_method :<<, :add_content

    def size
      content.size
    end

    def blank?
      content&.all?(&:blank?)
    end

    module ClassMethods
      # Create a new instance from a TipTap JSON object.
      # All nodes are recursively parsed and converted to Ruby objects
      # All nodes must be registered in the registry.
      # @param json [Hash] The JSON object to parse
      def from_json(json)
        return new if json.nil?

        json.deep_stringify_keys!

        content = Array(json["content"]).map do |node|
          TipTap.node_for(node["type"]).from_json(node)
        end

        new(content, **Hash(json["attrs"]))
      end
    end
  end
end
