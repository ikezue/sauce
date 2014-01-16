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

          # Skip to run `bundle install` manually.
          class_option :skip_bundle, default: true

          def initialize(args = ARGV, opts = {}, cfg = {})
            super
            copy_template_variables_to_instance_variables
          end

          def finish_template
            invoke :configure_database
            invoke :configure_dev_tools
            invoke :configure_specs
          end

          def configure_database
            build :postgres if 'postgresql' == options[:database]

            # Do this manually after project creation.
            # run %{ rake db:create }
          end

          def configure_dev_tools
            build :foreman
            build :pow
            build :rvm
            build :zeus
          end

          def configure_specs
            build :factory_girl
            build :rspec
          end

          protected

          # Override Rails::Generators::AppGenerator.get_builder_class
          def get_builder_class
            App::Builder
          end
        end
      end
    end
  end
end
