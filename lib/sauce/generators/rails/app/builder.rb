require 'rails/generators/rails/app/app_generator'

module Sauce
  module Generators
    module Rails
      module App
        class Builder < ::Rails::AppBuilder
          class << self
            def set_template_variable(key, value)
              @_template_variables ||= {}
              @_template_variables[key] = value
            end

            def template_variables
              @_template_variables || {}
            end
          end

          def initialize(generator)
            super
            copy_template_variables
          end

          def copy_template_variables
            self.class.template_variables.each do |key, value|
              instance_variable_set key, value
            end
          end
        end
      end
    end
  end
end
