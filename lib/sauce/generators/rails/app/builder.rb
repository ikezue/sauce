require 'rails/generators/rails/app/app_generator'
require 'helpers/template_variables'

module Sauce
  module Generators
    module Rails
      module App
        class Builder < ::Rails::AppBuilder
          # Any method defined in this class will override a method of the same
          # name in Rails::AppBuilder (http://bit.ly/I2wipm).
          include Helpers::TemplateVariables

          def initialize(generator)
            super
            copy_template_variables_to_instance_variables
          end

          def readme
            template 'README.md'
          end

          def gemfile
            copy_file 'local.Gemfile', 'Gemfile'
          end

          def gitignore
            copy_file 'local.gitignore', '.gitignore'
          end

          # ----------------------------------------------------------------- #

          def rvm
            template 'ruby-version', '.ruby-version'
          end

        end
      end
    end
  end
end
