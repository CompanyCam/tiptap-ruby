# frozen_string_literal: true

require "tip_tap/registry"

module TipTap
  module Registerable
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
  end
end
