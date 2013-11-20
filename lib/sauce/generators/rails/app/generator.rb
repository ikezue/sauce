require 'rails/generators'
require 'rails/generators/rails/app/app_generator'
require 'helpers/template_variables'

module Sauce
  module Generators
    module Rails
      module App
        class Generator < ::Rails::Generators::AppGenerator
          include Helpers::TemplateVariables

          class_option :skip_test_unit, type: :boolean, aliases: '-T', default: true,
                        desc: 'Skip Test::Unit files'

          class_option :database, type: :string, aliases: '-d', default: 'postgresql',
                        desc: "Select database to configure from: #{DATABASES.join '/'}"

          class_option :heroku, type: :boolean, aliases: '-H', default: false,
                        desc: 'Create staging and production Heroku apps'

          class_option :github, type: :string, aliases: '-G', default: nil,
                        desc: "Create a Github repo and add remote named 'github'"

          def initialize(args = ARGV, opts = {}, cfg = {})
            super
            copy_template_variables_to_instance_variables
          end

          def finish_template
            invoke :configure_tools
            invoke :configure_specs
          end

          def configure_tools
            build :rvm
          end

          def configure_specs
            build :factory_girl
            build :rspec
          end

          protected

          # Overrides Rails::Generators::AppGenerator.get_builder_class
          def get_builder_class
            App::Builder
          end
        end
      end
    end
  end
end
