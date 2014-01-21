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

          class_option :cucumber, type: :boolean, default: false,
                       desc: "True if running within a Cucubmer process"

          # Skip to run `bundle install` manually.
          class_option :skip_bundle, default: true
          # Skip to install at the appropriate time.
          class_option :skip_spring, default: true

          def initialize(args = ARGV, opts = {}, cfg = {})
            super
            copy_template_variables_to_instance_variables
          end

          def finish_template
            invoke :configure_env_development
            invoke :configure_env_test
            invoke :configure_env_staging
            invoke :configure_env_production
            invoke :finish_up
          end

          def configure_env_development
            say "Configuring environments: development\n"
            build :env_development
            build :dotenv
            build :foreman
            build :pow
            build :rvm
          end

          def configure_env_test
            say "Configuring environments: test\n"
            build :env_test
            build :factory_girl
          end

          def configure_env_staging
            say "Configuring environments: staging\n"
            build :env_staging
          end

          def configure_env_production
            say "Configuring environments: production\n"
            build :env_production
          end

          def finish_up
            say "\n"
            build :bundle

            build :rspec
            build :spring
            build :database

            build :git
            build :instructions
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
