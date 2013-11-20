require 'rails/generators'
require 'rails/generators/rails/app/app_generator'

module Sauce
  module Generators
    module Rails
      module App
        class Generator < ::Rails::Generators::AppGenerator
          class_option :skip_test_unit, type: :boolean, aliases: '-T', default: true,
                        desc: 'Skip Test::Unit files'

          class_option :database, type: :string, aliases: '-d', default: 'postgresql',
                        desc: "Select database to configure from: #{DATABASES.join '/'}"

          class_option :heroku, type: :boolean, aliases: '-H', default: false,
                        desc: 'Create staging and production Heroku apps'

          class_option :github, type: :string, aliases: '-G', default: nil,
                        desc: "Create a Github repo and add remote named 'github'"

          class << self
            def set_template_variable(key, value)
              @_template_variables ||= {}
              @_template_variables[key] = value
            end

            def template_variables
              @_template_variables || {}
            end
          end

          def initialize(args = ARGV, opts = {}, cfg = {})
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
