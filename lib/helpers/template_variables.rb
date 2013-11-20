module Helpers
  module TemplateVariables
    module ClassMethods
      def set_template_variable(key, value)
        @_template_variables ||= {}
        @_template_variables[key] = value
      end

      def template_variables
        @_template_variables || {}
      end
    end

    module InstanceMethods
      def copy_template_variables_to_instance_variables
        self.class.template_variables.each do |key, value|
          instance_variable_set key, value
        end
      end
    end

    def self.included(receiver)
      receiver.extend         ClassMethods
      receiver.send :include, InstanceMethods
    end
  end
end
