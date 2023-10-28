# frozen_string_literal: true

# This is the registry for all the nodes that TipTap knows about.
# It's a simple hash that maps TipTap JS node names to Ruby classes.
# Registering a new node is as simple as:
# TipTap::Registry.register('myNode', MyNode)
module TipTap
  class Registry
    MissingNodeError = Class.new(StandardError)

    def self.register(name, klass)
      registry[name.to_s] = klass
    end

    def self.node_for(name)
      registry.fetch(name.to_s) { raise MissingNodeError.new("Unknown node type: #{name}") }
    end

    def self.clear
      @registry = {}
    end

    def self.registry
      @registry ||= {}
    end
  end
end
